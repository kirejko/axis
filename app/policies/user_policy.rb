# frozen_string_literal: true

# User policy
class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  # Can create users?
  def create?
    manages_users?
  end

  def update?
    manages_users? && user.id != record.id
  end

  def destroy?
    manages_users? && user.id != record.id
  end

  private

  def manages_users?
    %i[admin recruiter director].include?(user.role)
  end
end
