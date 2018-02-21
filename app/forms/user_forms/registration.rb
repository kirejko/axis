# frozen_string_literal: true

module UserForms
  # Handles creating of the user by the admin roles
  class Registration
    include ActiveModel::Model

    attr_accessor(
      :avatar, :email, :password, :role,
      :first_name, :last_name, :middle_name,
      :gender, :birthday, :notes,
      :position, :gmail, :skype, :phone1, :phone2,
      :trial_at, :remote_worker, :remote_hourly
    )

    validates :avatar,      presence: true
    validates :email,       presence: true
    validates :password,    presence: true, length: { in: 8..32 }, confirmation: true, if: -> { password.present? }
    validates :first_name,  presence: true, length: { in: 2..32 }, if: -> { first_name.present? }
    validates :last_name,   presence: true, length: { in: 2..32 }, if: -> { last_name.present? }
    validates :position,    presence: true
    validates :gmail,       presence: true, email: true, if: -> { gmail.present? }
    validates :skype,       presence: true
    validates :phone1,      presence: true
    validates :birthday,    presence: true
    validates :trial_at,    presence: true
    # validates :remote_worker, presence: true

    def self.model_name
      ActiveModel::Name.new(self, nil, 'Register')
    end

    def save
      return false unless valid?
      persist!
      true
    end

    private

    def persist!
      ActiveRecord::Base.transaction do
        user = User.create!(email: email, password: password, avatar: avatar)
        user.create_profile(
          first_name: first_name, last_name: last_name, middle_name: middle_name, gender: gender, birthday: birthday,
          position: position, notes: notes, gmail: gmail, skype: skype, phone1: phone1, phone2: phone2,
          trial_at: trial_at, remote_worker: remote_worker, remote_hourly: remote_hourly
        )
      end
    end
  end
end
