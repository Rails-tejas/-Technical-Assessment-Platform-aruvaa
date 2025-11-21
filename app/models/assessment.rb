class Assessment < ApplicationRecord
  belongs_to :candidate
  
  has_many :assessment_questions, dependent: :destroy
  has_many :questions, through: :assessment_questions

  enum :status, ["in_progress", "completed"], default: "in_progress"

end
