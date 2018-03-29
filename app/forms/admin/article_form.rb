module Admin
  # ArticleForm
  class ArticleForm
    include ActiveModel::Model

    attr_accessor :title, :body
    attr_reader :article, :user

    validates :title, presence: true, length: { in: 3..255 }
    validates :body, presence: true, length: { minimum: 10 }

    def self.model_name
      ActiveModel::Name.new(self, nil, 'Article')
    end

    def initialize(user: nil, article: nil, attributes: {})
      if article.nil?
        @user = user
      else
        @article = article
        super(article_attributes.merge(attributes))
      end

      super(attributes)
    end

    def save
      return false unless valid?

      create_article
      true
    end

    def update
      return false unless valid?

      update_article
      true
    end

    private

    def article_attributes
      {
        title: article.title,
        body:  article.body
      }
    end

    def article_permitted_params
      {
        title: title,
        body:  body
      }
    end

    def create_article
      ActiveRecord::Base.transaction do
        @article = @user.articles.create!(article_permitted_params)
      end
    end

    def update_article
      ActiveRecord::Base.transaction do
        @article.update!(article_permitted_params)
      end
    end
  end
end