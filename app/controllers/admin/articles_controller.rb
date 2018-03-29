module Admin
  # ArticlesController
  class ArticlesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_article, only: %i[edit update destroy]
    before_action :authorize_create?, only: %i[new create]
    before_action :authorize_update?, only: %i[edit update]

    def index
      @articles = Article.page(params[:page]).decorate
    end

    def new
      @form = Admin::ArticleForm.new
    end

    def create
      @form = Admin::ArticleForm.new(
        user:       current_user,
        attributes: article_params
      )

      if @form.save
        redirect_to admin_articles_url, notice: "Article has been created."
      else
        render :new
      end
    end

    def edit
      @form = Admin::ArticleForm.new(article: @article)
    end

    def update
      @form = Admin::ArticleForm.new(article: @article, attributes: article_params)
      if @form.update
        redirect_to admin_articles_url, notice: "Article has been updated."
      else
        render :edit
      end
    end

    def destroy
      @article.destroy!
      render json: { message: "Article has been deleted.", status: :deleted }
    end

    private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :body)
    end

    def authorize_create?
      authorize_action? :create?
    end

    def authorize_update?
      authorize_action? :update?
    end

    def authorize_action?(action)
      authorize Article, action
    end
  end
end
