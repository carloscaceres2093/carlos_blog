class ArticlesController < ApplicationController
	before_action :set_article, only:[:edit,:update, :show,:destroy]
	def home
	
	end
	def index
		@article = Article.all
	end
	def new
		@article = Article.new
	end
	def create
		@article = Article.new(article_params)
		if @article.save
			flash[:notice] = "Article was successfull created "
			redirect_to article_path(@article)
		else
			render "new"
		end
	end
	def show
	end
	def edit
	end
	def update
		if @article.update(article_params)
			flash[:notice] = "Article was successfull updated"
			redirect_to article_path(@article)
		else
			render 'edit'
		end

	end
	def destroy 
		@article.destroy
		flash[:notice] = "Article was successfull deleted"
		redirect_to articles_path
	end

	private
		def set_article
			@article = Article.find(params[:id])
		end

		def article_params
			params.require(:article).permit(:title, :description)
		end
end