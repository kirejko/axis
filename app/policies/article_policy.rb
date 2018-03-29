# ArticlePolicy
class ArticlePolicy < ApplicationPolicy
  attr_reader :user, :article

  def initialize(auth_context, article)
    @user = auth_context.user
    @article = article
  end

  def create?
    can_manage_articles?
  end

  def update?
    can_manage_articles?
  end

  def destroy?
    can_manage_articles?
  end

  private

  def can_manage_articles?
    %i[admin recruiter director].include?(user.role.to_sym)
  end
end
