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

    validates :email, presence: true, email: true, if: -> { email.present? }
    validates :password, presence: true, length: { in: 8..32 }, confirmation: true, if: -> { password.present? }
    validates :first_name, presence: true, length: { in: 2..32 }, if: -> { first_name.present? }
    validates :last_name, presence: true, length: { in: 2..32 }, if: -> { last_name.present? }
    validates :position, presence: true, length: { in: 2..32 }, if: -> { position.present? }
    validates :gmail, presence: true, email: true, if: -> { gmail.present? }
    validates :skype, presence: true
    validates :phone1, presence: true
    validates :phone2, presence: true
    validates :birthday, presence: true
    validates :remote_worker, presence: true
    validates :remote_hourly, presence: true
    validates :trial_at, presence: true
    validates :hired_at, presence: true
    validates :fired_at, presence: true
    validates :department, presence: true

    def self.model_name
      ActiveModel::Name.new(self, nil, 'profile')
    end

    def initialize(user, attributes = {})
      @user = user
      super(user_flat_parameters.merge(attributes))
    end

    def user_flat_parameters
      {
        avatar:        user.avatar,
        email:         user.email,
        password:      user.password,
        department:    user.department,
        first_name:    user.profile.first_name,
        middle_name:   user.profile.middle_name,
        last_name:     user.profile.last_name,
        position:      user.profile.position,
        gmail:         user.profile.gmail,
        skype:         user.profile.skype,
        phone1:        user.profile.phone1,
        phone2:        user.profile.phone2,
        birthday:      user.profile.birthday,
        trial_at:      user.profile.trial_at,
        hired_at:      user.profile.hired_at,
        fired_at:      user.profile.fired_at,
        remote_worker: user.profile.remote_worker,
        remote_hourly: user.profile.remote_hourly,
      }
    end

    def update
      ActiveRecord::Base.transaction do
        @user.update!(
          avatar:     avatar,
          email:      email,
          password:   password
        )
        # @todo: ...
      end
    end

  end
end