# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true

      t.string  :first_name,    null: false, default: ''
      t.string  :middle_name,   null: false, default: ''
      t.string  :last_name,     null: false, default: ''

      t.integer :gender
      t.date    :birthday
      t.string  :moto
      t.text    :bio
      t.text    :notes

      t.string  :gmail
      t.string  :skype
      t.string  :phone1
      t.string  :phone2
      t.string  :address

      t.string  :position
      t.boolean :remote_worker, default: false
      t.boolean :remote_hourly, default: false

      t.date    :trial_at
      t.date    :hired_at
      t.date    :fired_at
      t.integer :fired_as

      t.timestamps
    end
  end
end
