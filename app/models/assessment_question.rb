class AssessmentQuestion < ApplicationRecord
  belongs_to :assessment
  belongs_to :question
end
