# frozen_string_literal: true

# Pubdit authorization context
class AuthContext
  attr_reader :user

  def initialize(user)
    @user = user
  end
end
