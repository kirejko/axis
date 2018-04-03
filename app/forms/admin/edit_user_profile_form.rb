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
    validates :password, presence: false, length: { in: 8..32 }, confirmation: true, unless: -> { password.blank? }
    validates :first_name, presence: true, length: { in: 2..32 }, if: -> { first_name.present? }
    validates :last_name, presence: true, length: { in: 2..32 }, if: -> { last_name.present? }
    validates :position, presence: true, length: { in: 2..32 }, if: -> { position.present? }
    validates :gmail, presence: true, email: true, if: -> { gmail.present? }
    validates :department, exists: true, allow_nil: true
    validates :skype, presence: true
    validates :phone1, presence: true
    validates :phone2, presence: false
    validates :birthday, presence: true
    validates :remote_worker, presence: true
    validates :remote_hourly, presence: true
    validates :trial_at, presence: false
    validates :hired_at, presence: false
    validates :fired_at, presence: false
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
        department:    user.department_id,
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
        remote_hourly: user.profile.remote_hourly
      }
    end

    def user_with_profile_attrs
      attributes = {
        avatar:             avatar,
        email:              email,
        department:         department,
        profile_attributes: {
          first_name:    first_name,
          middle_name:   middle_name,
          last_name:     last_name,
          position:      position,
          gmail:         gmail,
          skype:         skype,
          phone1:        phone1,
          phone2:        phone2,
          birthday:      birthday,
          trial_at:      trial_at,
          hired_at:      hired_at,
          fired_at:      fired_at,
          remote_worker: remote_worker,
          remote_hourly: remote_hourly
        }
      }

      attributes.merge(password: password) unless password.blank?
    end

    def update
      return false unless valid?

      ActiveRecord::Base.transaction do
        @user.update!(user_with_profile_attrs)
      end
    end

  end
end