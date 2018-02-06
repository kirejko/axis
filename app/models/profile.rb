# frozen_string_literal: true

# User profile model
class Profile < ApplicationRecord

  GENDERS = { male: 0, female: 1 }.freeze
  enum gender: GENDERS

  belongs_to :user, touch: true

  validates :first_name,  presence: true, length: { in: 2..32 }
  validates :last_name,   presence: true, length: { in: 2..32 }

  after_initialize do |profile|
    profile.gender ||= GENDERS[:male]
  end

end
