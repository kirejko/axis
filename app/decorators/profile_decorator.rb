# Profile decorator
class ProfileDecorator < ApplicationDecorator
  delegate_all

  def position
    object.position.gsub(/\b\w/, &:upcase)
  end

end
