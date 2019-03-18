require 'test_helper'
class CreateArticlesTest < ActionDispatch::IntegrationTest
	def setup
		@user = User.create(username:'carlos',email:'carlos@hola.com', password:'password',admin:false)
	end
	test "get new article form and create article" do
		sign_in_as(@user,'password')
		get new_article_path #Emulation user action to go to create new article
		assert_template 'articles/new' # redirect to new form
		assert_difference 'Article.count',1 do #create a new article
			post articles_path, params:{article:{title:"New article test", description:"This is my artcile test"}}
			follow_redirect!
		end
		assert_template 'articles/show' #redirect to index template
		assert_match "New article test", response.body #show articles that were created
	end	
	test "invalid article submission result in failure" do
		sign_in_as(@user,'password')
		get new_article_path #Emulation user action to go to create new category
		assert_template 'articles/new' # redirect to new form
		assert_no_difference 'Article.count' do #create a new category
			post articles_path, params:{article:{title:" ", description:" "}}
		end
		assert_template 'articles/new' #redirect to new template, since category is wrong
		assert_select "h2.panel-title" #Sentence in _errors
		assert_select "div.panel-body"
		
	end

end
