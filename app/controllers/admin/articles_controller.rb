module Admin
  # ArticlesController
  class ArticlesController < ApplicationController
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
        redirect_to admin_articles_url, notice: t('admin.article.messages.create.success')
      else
        render :new
      end
    end

    def edit
      @form = Admin::ArticleForm.new(article: @article)
    end

    def update
      @form = Admin::ArticleForm.new(
        article:    @article,
        attributes: article_params
      )

      if @form.update
        redirect_to admin_articles_url, notice: t('admin.article.messages.update.success')
      else
        render :edit
      end
    end

    def destroy
      @article.destroy!
      render json: { message: t('admin.article.messages.delete.success'), status: :deleted }
    end

    private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :body, attachments: [])
    end

    def authorize_create?
      authorize Article, :create?
    end

    def authorize_update?
      authorize @article, :update?
    end
  end
end
