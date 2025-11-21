class Language < ApplicationRecord
  has_many :questions, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
