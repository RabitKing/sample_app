require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup 
    @user = User.new(name: "Example name", email:
    "example@gmail.com", password: "foobar",
    password_confirmation: "foobar")
  end
  
  test "Should be valid" do 
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "      "
    assert_not @user.valid?
  end
  
  test "email should be present" do 
    @user.email = "   "
    assert_not @user.valid?
  end
  
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  test "email should not be too long" do 
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "email should be the correct format" do
    correct_format = %w[user@example.com USER@foo.COM
    first.last@foo.jp THE_US_ER@foo.bar.org]
    correct_format.each do |correct_emails|
      @user.email = correct_emails
      assert @user.valid? "Email #{correct_emails} should be valid!"
    end
  end
  
  test "email validation should reject invalid emails" do 
    incorrect_format = %w[user@example,com foo@bar+baz.com
    user.name@example.foo@bar_baz.com user_at_foo.org]
    incorrect_format.each do |incorrect_emails|
      @user.email = incorrect_emails
      assert_not @user.valid?
    end
  end
  
  test "email address should be unique" do 
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save 
    assert_not duplicate_user.valid?
  end
  
  test "password should have a minimum length" do 
    @user.password = @user.password_confirmation = "a"* 5
    assert_not @user.valid?
  end 
end
