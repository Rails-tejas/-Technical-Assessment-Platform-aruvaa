class SessionsController < ApplicationController
  # PASS_THRESHOLD = 5   # adjust as needed

  # params expected: selected_language_ids: []
  def start_test
    selected_ids = Array(params[:selected_language_ids]).map(&:to_i)
    if selected_ids.empty?
      redirect_to root_path, alert: "Please select at least one language"
      return
    end

    # create anonymous candidate if none
    candidate = Candidate.create!(name: params[:name].presence || "Anonymous")

    # gather questions for selected languages
    questions = Question.where(language_id: selected_ids).to_a
    questions.shuffle!

    # you might want to limit number of questions; example limit = 10
    questions = questions.first(10) if questions.size > 10

    # create assessment
    assessment = candidate.assessments.create!(
      total_questions: questions.size,
      status: "in_progress"
    )

    # create assessment_question entries
    questions.each do |q|
      assessment.assessment_questions.create!(question: q)
    end

    # store in session
    session[:assessment_id] = assessment.id
    session[:current_index] = 0
    session[:score] = 0

    redirect_to assessment_question_path
  end
end
