class AddTimerFieldsToAssessmentQuestions < ActiveRecord::Migration[8.0]
  def change
    add_column :assessment_questions, :time_left, :integer
    add_column :assessment_questions, :timer_started_at, :datetime
  end
end
