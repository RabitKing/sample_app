require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "for invalid user information" do 
    get signup_path
    assert_no_difference 'User.count' do 
      post users_path, user:{
        name:                  "", 
        email:                 "user@invalid", 
        password:              "boobs",
        password_confirmation: "boby"
      }
    end
    assert_template 'users/new'
  end
  
  test "for valid submissions" do 
    get signup_path
    assert_difference 'User.count', 1 do 
      post_via_redirect users_path user:{
        name:                  "Carl Thomas", 
        email:                 "thom@gmail.com",
        password:              "thomas", 
        password_confirmation: "thomas"
      }
    end
    assert_template 'users/show'
  end
end