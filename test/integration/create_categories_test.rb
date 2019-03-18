require 'test_helper'
class CreateCategoriesTest < ActionDispatch::IntegrationTest
	def setup
		@user = User.create(username:'carlos',email:'carlos@hola.com', password:'password',admin:true)
	end
	test "get new category form and create category" do
		sign_in_as(@user,'password')
		get new_category_path #Emulation user action to go to create new category
		assert_template 'categories/new' # redirect to new form
		assert_difference 'Category.count',1 do #create a new category
			post categories_path, params:{category:{name:"sports"}}
			follow_redirect!
		end
		assert_template 'categories/index' #redirect to index template
		assert_match "sports", response.body #show categories that were created
	end	
	test "invalid category submission result in failure" do
		sign_in_as(@user,'password')
		get new_category_path #Emulation user action to go to create new category
		assert_template 'categories/new' # redirect to new form
		assert_no_difference 'Category.count' do #create a new category
			post categories_path, params:{category:{name:" "}}
		end
		assert_template 'categories/new' #redirect to new template, since category is wrong
		assert_select "h2.panel-title" #Sentence in _errors
		assert_select "div.panel-body"
		
	end
end
