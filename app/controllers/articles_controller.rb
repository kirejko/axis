# ArticlesController
class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = Article.page(params[:page]).decorate
  end

  def show
    @article = Article.find(params[:id]).decorate
  end
end
