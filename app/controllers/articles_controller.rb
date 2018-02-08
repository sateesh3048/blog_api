class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :update, :destroy]
  skip_before_action :authorize_request, only: [:index, :show]

  def index
    articles = Article.all
    json_response(articles) 
  end

  def create
    @article = Article.create!(article_params)
    json_response(@article, :created)
  end

  def show
    json_response(@article)
  end

  def update
    @article.update!(article_params)
    json_response(@article)
  end

  def destroy
    @article.destroy
    head :no_content
  end

  private 
    def article_params
      params.require(:article).permit(:title, :content, :user_id)
    end

    def set_article
      @article = Article.find(params[:id])
    end
end
