class Candidate < ApplicationRecord
  has_many :assessments, dependent: :destroy
  has_one_attached :resume
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
end
