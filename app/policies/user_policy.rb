# frozen_string_literal: true

# User policy
class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(auth_context, record)
    @user = auth_context.user
    @record = record
  end

  # Can create users?
  def create?
    can_manage_users?
  end

  def update?
    can_manage_users?
  end

  def destroy?
    can_manage_users? && user.id != record.id
  end

  private

  def can_manage_users?
    %i[admin recruiter director].include?(user.role.to_sym)
  end
end
