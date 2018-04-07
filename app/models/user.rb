# frozen_string_literal: true

# User model
class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :recoverable, :rememberable,
         :trackable, :lockable, :validatable

  ROLES = { admin: 0, user: 1, accountant: 2, lead: 3, manager: 4, recruiter: 5, director: 6 }.freeze
  enum role: ROLES

  # Relations
  has_one :profile, dependent: :destroy, autosave: true
  belongs_to :department, optional: true, counter_cache: true
  has_many :articles

  # Nested attributes
  accepts_nested_attributes_for :profile, update_only: true

  # Default values
  default_value_for :role, ROLES[:user]

  # Hooks
  before_save :downcase_email
  # before_save :avatar_size_validation, if: -> { avatar.present? }

  # scopes
  scope :ordered, -> { joins(:profile).merge(Profile.ordered) }

  # Validate email for uniqueness
  validates :email, uniqueness: { case_sensitive: false }, email: true, on: :create

  # Validate avatar when creating user
  validates_integrity_of :avatar, on: :create
  validates_processing_of :avatar, on: :create
  # Validate avatar when updating user
  validates_integrity_of :avatar, on: :update, if: -> { avatar.present? }
  validates_processing_of :avatar, on: :update, if: -> { avatar.present? }

  # Pagination
  paginates_per 18

  def admin?
    :admin.equal? role.to_sym
  end

  def top_manager?
    %i[admin recruiter director].include?(role.to_sym)
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def avatar_size_validation
    errors[:avatar] << 'should be less than 2MB' if avatar.size > 2.megabytes
  end
end
