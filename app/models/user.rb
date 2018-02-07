# frozen_string_literal: true

# User model
class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :recoverable, :rememberable,
         :trackable, :lockable, :validatable

  ROLES = { admin: 0, user: 1, lead: 2, manager: 3, recruiter: 4, director: 5 }.freeze
  enum role: ROLES

  has_one :profile, inverse_of: :user, dependent: :destroy
  accepts_nested_attributes_for :profile

  # Downcase email before saving model
  before_save :downcase_email

  # E-mail validation
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true, if: -> { email.present? }
  validates :password, confirmation: true, length: { minimum: 8 }

  # User Avatar Validation
  validates_integrity_of  :avatar
  validates_processing_of :avatar

  # Pagination
  paginates_per 18

  after_initialize do |user|
    user.role ||= ROLES[:user]
  end

  def to_s
    "#{profile.first_name} #{profile.last_name}"
  end

  private

  def downcase_email
    self.email = email.delete(' ').downcase
  end

  def avatar_size_validation
    errors[:avatar] << 'should be less than 2MB' if avatar.size > 2.megabytes
  end
end
