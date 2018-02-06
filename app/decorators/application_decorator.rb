# frozen_string_literal: true

# Main applicatoin decorator
class ApplicationDecorator < Draper::Decorator

  def self.collection_decorator_class
    PaginationDecorator
  end

end