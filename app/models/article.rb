class Article < ApplicationRecord
  # Associations
  belongs_to :user
  # Validations
  validates :title, :content, presence: true
end
