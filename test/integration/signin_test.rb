require 'test_helper'

class SigninTest < ActionDispatch::IntegrationTest
	def setup
	end
	test "get successfull sign up " do
		get signup_path #Emulation user action to go to create new article
		assert_template 'users/new' # redirect to new form
		assert_difference 'User.count',1 do #create a new article
			post users_path, params:{user:{username:"CCaceres", email:"Hola123@gmail.com", password:"password", admin:false}}
			follow_redirect!
		end
		assert_template 'users/show' #redirect to index template
		assert_match "CCaceres", response.body #show articles that were created

	end
	test "get missing data" do
		get signup_path #Emulation user action to go to create new article
		assert_template 'users/new' # redirect to new form
		assert_no_difference 'User.count' do #create a new article
			post users_path, params:{user:{username:" ", email:"  ", password:" ", admin:false}}
		end
		assert_template 'users/new' #redirect to index template
		assert_select "h2.panel-title" #Sentence in _errors
		assert_select "div.panel-body"
	end
		
end
