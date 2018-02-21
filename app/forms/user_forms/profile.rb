# frozen_string_literal: true

module UserForms
  # Handles changes in personal profile by the account owner
  class Registration
    include ActiveModel::Model

    attr_accessor(
      :avatar, :last_name, :first_name, :middle_name,
      :phone1, :phone2, :moto, :bio, :birthday
    )

    validates :first_name,  presence: true, length: { in: 2..32 }, if: -> { first_name.present? }
    validates :last_name,   presence: true, length: { in: 2..32 }, if: -> { last_name.present? }
    validates :middle_name, length: { in: 2..32 }, if: -> { middle_name.present? }
    validates :phone1,      presence: true
    validates :phone2
    validates :birthday,    presence: true
    validates :moto
    validates :bio

    def self.model_name
      ActiveModel::Name.new(self, nil, 'Profile')
    end

    def save
      return false unless valid?
      persist!
      true
    end

    private

    def persist!
      Profile.transaction do
        
      end
    end

  end
end