# frozen_string_literal: true

# Department policy
class DepartmentPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(auth_context, record)
    @user   = auth_context.user
    @record = record
  end

  # Can create users?
  def create?
    can_manage_departments?
  end

  def update?
    can_manage_departments?
  end

  def destroy?
    can_manage_departments?
  end

  private

  def can_manage_departments?
    %i[admin director].include?(user.role.to_sym)
  end
end
