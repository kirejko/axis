# frozen_string_literal: true

# Department
class Department < ApplicationRecord
  has_many :users, dependent: :nullify
end
