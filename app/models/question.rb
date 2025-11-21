class Question < ApplicationRecord
  belongs_to :language
  has_many :assessment_questions
  validates :question_text, presence: true
  validates :options, presence: true
end
