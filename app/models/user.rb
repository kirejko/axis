# frozen_string_literal: true

# User model
class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :recoverable, :rememberable,
         :trackable, :lockable, :validatable

  ROLES = { admin: 0, user: 1, lead: 2, manager: 3, recruiter: 4, director: 5 }.freeze
  enum role: ROLES

  # Relations
  has_one :profile, dependent: :destroy, autosave: true
  accepts_nested_attributes_for :profile

  # Default values
  default_value_for :role, ROLES[:user]

  # Hooks
  before_save :downcase_email

  # scopes
  scope :ordered, -> { joins(:profile).merge(Profile.ordered) }

  # Validations
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            email: true,
            if: -> { email.present? },
            on: %i[create update]

  validates :password,
            confirmation: true,
            length: { minimum: 8 },
            if: -> { password.present? },
            on: %i[create]

  validates_integrity_of  :avatar
  validates_processing_of :avatar

  # Pagination
  paginates_per 18

  private

  def downcase_email
    self.email = email.downcase
  end

  def avatar_size_validation
    errors[:avatar] << 'should be less than 2MB' if avatar.size > 2.megabytes
  end
end
