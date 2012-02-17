#RSpec::Matchers.define :have_error_message do |message|
#  match do |page|
#    page.should have_selector('div.flash.error', text: message)
#  end
#end
#
#def valid_signin(user)
#  fill_in "Email",    with: user.email
#  fill_in "Password", with: user.password
#  click_button "Sign in"
#end

Given /^a user visits the signin page$/ do
  visit signin_path
end

When /^he submits invalid signin information$/ do
  click_button "Sign in"
end

Then /^he should see an error message$/ do
  page.should have_selector('div.flash.error')
  page.should have_error_message('Invalid')
end

Given /^the user has an account$/ do
  @user = User.create(name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
end

When /^the user submits valid signin information$/ do
  visit signin_path
  valid_signin(@user)
  #fill_in "Email",    with: @user.email
  #fill_in "Password", with: @user.password
  #click_button "Sign in"
end

Then /^he should see his profile page$/ do
  page.should have_selector('title', text: @user.name)
end

Then /^he should see a signout link$/ do
  puts signout_path
  page.should have_link('Sign out', href: signout_path)
end