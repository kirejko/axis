# frozen_string_literal: true

module Admin
  # Handles creating of the user by the admin roles
  class UserRegistrationForm
    include ActiveModel::Model

    attr_accessor(
      :avatar, :email, :password,
      :first_name, :last_name, :middle_name,
      :position, :department, :remote_worker, :remote_hourly,
      :gmail, :skype, :phone1, :phone2,
      :gender, :birthday, :notes,
    )

    validates :avatar,        presence: true
    validates :email,         presence: true, email: { domains: ['amgrade.com'] }, if: -> { email.present? }
    validates :password,      presence: true, length: { in: 8..32 }, confirmation: true, if: -> { password.present? }
    validates :first_name,    presence: true, length: { in: 2..32 }, if: -> { first_name.present? }
    validates :last_name,     presence: true, length: { in: 2..32 }, if: -> { last_name.present? }
    validates :position,      presence: true, length: { in: 2..32 }, if: -> { position.present? }
    validates :gmail,         presence: true, email: { domains: ['gmail.com'] }, if: -> { gmail.present? }
    validates :skype,         presence: true
    validates :phone1,        presence: true
    validates :birthday,      presence: true, birthday: true
    validates :remote_worker, presence: true
    validates :remote_hourly, presence: true

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
          first_name: first_name,
          last_name: last_name,
          middle_name: middle_name,
          gender: gender,
          birthday: birthday,
          position: position,
          notes: notes,
          gmail: gmail,
          skype: skype,
          phone1: phone1,
          phone2: phone2,
          remote_worker: remote_worker,
          remote_hourly: remote_hourly
        )
      end
    end
  end
end
