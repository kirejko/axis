# frozen_string_literal: true

module Admin
  # Handles editing of the user
  class EditUserProfileForm
    include ActiveModel::Model

    attr_accessor(
      :avatar, :email, :password,
      :first_name, :last_name, :middle_name,
      :position, :department, :remote_worker, :remote_hourly,
      :gmail, :skype, :phone1, :phone2,
      :gender, :birthday, :notes,
      :trial_at, :hired_at, :fired_at, :fired_as
    )
    attr_reader :user

    validates :email,         presence: true, email: true, if: -> { email.present? }
    validates :password,      presence: true, length: { in: 8..32 }, confirmation: true, if: -> { password.present? }
    validates :first_name,    presence: true, length: { in: 2..32 }, if: -> { first_name.present? }
    validates :last_name,     presence: true, length: { in: 2..32 }, if: -> { last_name.present? }
    validates :position,      presence: true, length: { in: 2..32 }, if: -> { position.present? }
    validates :gmail,         presence: true, email: true, if: -> { gmail.present? }
    validates :skype,         presence: true
    validates :phone1,        presence: true
    validates :birthday,      presence: true
    validates :remote_worker, presence: true
    validates :remote_hourly, presence: true
    validates :trial_at,      presence: true, timeliness: { type: :date }
    validates :hired_at,      presence: true, timeliness: { type: :date }
    validates :fired_at,      timeliness: { type: :date }

    def self.model_name
      ActiveModel::Name.new(self, nil, 'User')
    end



  end
end