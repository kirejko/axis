# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string    :email,                     null: false, default: ''
      t.string    :encrypted_password,        null: false, default: ''
      t.string    :reset_password_token
      t.datetime  :reset_password_sent_at
      t.datetime  :remember_created_at
      t.integer   :sign_in_count,             null: false, default: 0
      t.datetime  :current_sign_in_at
      t.datetime  :last_sign_in_at
      t.inet      :current_sign_in_ip
      t.inet      :last_sign_in_ip
      t.integer   :failed_attempts,           null: false, default: 0
      t.datetime  :locked_at
      t.integer   :role
      t.string    :avatar

      t.timestamps null: false
    end

    add_index :users, :email,                 unique: true
    add_index :users, :reset_password_token,  unique: true
  end
end
