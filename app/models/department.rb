# frozen_string_literal: true

# Department
class Department < ApplicationRecord
  # relations
  has_many :users, dependent: :nullify

  # scopes
  default_scope { order(users_count: :desc) }

  # Pagination
  paginates_per 18
end
