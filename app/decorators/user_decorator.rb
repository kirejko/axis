# frozen_string_literal: true

# User model decorator
class UserDecorator < Draper::Decorator
  delegate_all

  decorates_association :profile

  def self.collection_decorator_class
    PaginatingDecorator
  end
end
