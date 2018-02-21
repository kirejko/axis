# frozen_string_literal: true

# Departments table
class CreateDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :departments do |t|
      t.string :name, null: false, default: ''
      t.text   :description

      t.timestamps
    end
  end
end
