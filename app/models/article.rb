# User model
class Article < ApplicationRecord
  # Relations
  belongs_to :user

  # Pagination
  paginates_per 5
end
