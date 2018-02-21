# frozen_string_literal: true

# Add department reference to user
class AddDepartmentToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :department, foreign_key: true
  end
end
