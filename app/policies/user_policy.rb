# frozen_string_literal: true

# User policy
class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(authorization_context, record)
    @user = authorization_context.user
    @record = record
  end

  # Can create users?
  def create?
    user.admin? || user.recruiter? || user.director?
  end
end
