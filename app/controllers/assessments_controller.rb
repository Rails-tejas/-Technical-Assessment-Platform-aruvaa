class AssessmentsController < ApplicationController
	PER_QUESTION_SECONDS = 30

   before_action :load_assessment

def show
  idx = session[:current_index] || 0
  @index = idx
  @aq = @assessment.assessment_questions.includes(:question).order(:id)[idx]
  redirect_to assessment_result_path and return unless @aq

  @question = @aq.question

  # initialize timer if not started
  if @aq.time_left.nil?
    @aq.update!(
      time_left: PER_QUESTION_SECONDS,
      timer_started_at: Time.current
    )
  end

  # update remaining time
  elapsed = Time.current - @aq.timer_started_at
  remaining = @aq.time_left - elapsed.to_i

  @remaining_seconds = remaining.positive? ? remaining : 0

  # auto-submit if time is over
  if @remaining_seconds <= 0
    params[:auto] = true
    return auto_submit(aq: @aq)
  end
end


def auto_submit(aq:)
  # if already correct, score stays
  if aq.correct
    # nothing
  else
    # mark wrong because time expired
    aq.update(correct: false)
  end

  session[:current_index] += 1

  if session[:current_index] >= @assessment.total_questions
    finalize_assessment
    redirect_to assessment_result_path
  else
    redirect_to assessment_question_path
  end
end


def answer
  selected = params[:selected_answer]
  nav = params[:nav] # "next", "previous", "submit"

  idx = session[:current_index] || 0
  aq = @assessment.assessment_questions.order(:id)[idx]
  return redirect_to assessment_result_path unless aq

  # Fix scoring: undo previous score if needed
  if aq.correct
    session[:score] = (session[:score] || 0) - 1
  end

  # Save answer only on next/submit
  if nav != "previous"
    is_correct = (selected.to_s.strip == aq.question.correct_answer.to_s.strip)

    aq.selected_answer = selected
    aq.correct = is_correct
    aq.save!

    # Add score for new answer
    session[:score] = (session[:score] || 0) + (is_correct ? 1 : 0)
  end

  # Navigation
  if nav == "previous"
    session[:current_index] = [idx - 1, 0].max
    redirect_to assessment_question_path and return
  end

  if nav == "next"
    session[:current_index] = idx + 1
    redirect_to assessment_question_path and return
  end

  if nav == "submit"
    @assessment.update!(
      score: session[:score],
      passed: session[:score] >= pass_threshold,
      status: "completed"
    )

    @assessment.candidate.update!(score: session[:score], passed: @assessment.passed)
    redirect_to assessment_result_path and return
  end
end


  def result
    @score = @assessment.score || session[:score] || 0
    @passed = @assessment.passed
  end

  def previous
	  idx = session[:current_index] || 0
	  new_index = idx - 1
	  new_index = 0 if new_index < 0

	  session[:current_index] = new_index
	  redirect_to assessment_question_path
  end

  

  private

  def load_assessment
    @assessment = Assessment.find_by(id: session[:assessment_id])
    unless @assessment
      redirect_to root_path, alert: "No active assessment. Please start a test." and return
    end
  end

  def pass_threshold
    (@assessment.total_questions * 0.7).ceil
  end

  def finalize_assessment
    @attempt = AssessmentAttempt.find_by(id: session[:attempt_id])

    return unless @attempt

    @attempt.update(
      score: session[:score],
      completed_at: Time.current
    )

    # Clear session variables
    session[:current_index] = nil
    session[:score] = nil
    session[:attempt_id] = nil
  end

end
