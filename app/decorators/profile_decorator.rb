# frozen_string_literal: true

# Profile decorator
class ProfileDecorator < Draper::Decorator
  delegate_all

  # def position
  #   object.position&.titleize
  # end
end
