# frozen_string_literal: true

# User profile model
class Profile < ApplicationRecord

  GENDERS = { male: 0, female: 1 }.freeze
  enum gender: GENDERS

  # Ralations
  belongs_to :user, touch: true

  # Default values
  default_value_for :gender, GENDERS[:male]

  # Hooks
  before_save :downcase_gmail
  before_save :downcase_skype

  # Scopes
  scope :ordered, -> { order(last_name: :asc) }

  # Validations
  validates :first_name,  presence: true, length: { in: 2..32 }, if: -> { first_name.present? }
  validates :last_name,   presence: true, length: { in: 2..32 }, if: -> { last_name.present? }
  validates :position,    presence: true
  validates :gmail,       presence: true, email: true, if: -> { gmail.present? }
  validates :skype,       presence: true
  validates :phone1,      presence: true
  validates :birthday,    presence: true
  validates :trial_at,    presence: true
  # validates :remote_worker, presence: true

  # Virtual attributes
  def full_name=(name)
    names = name.split(' ', 2)
    self.first_name = names.first
    self.last_name  = names.last
  end

  def full_name
    [last_name, first_name].compact.join(' ')
  end

  private

  def downcase_gmail
    self.gmail = gmail.downcase unless gmail.nil?
  end

  def downcase_skype
    self.skype = skype.downcase unless skype.nil?
  end

end
