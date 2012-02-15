require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it "should have correct title" do
      should have_selector('h1', content: "Sign up")
    end
    specify { should have_selector('h1', content: "Sign up") }
    specify { should have_selector('title', :content => "Sign Up") }
  end

  describe "profile page" do

    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it "should show name on the page" do
      should have_selector('h1', content: user.name)
    end

    it "should have title with name" do
      should have_selector('title', content: user.name)
    end
  end


 describe "signup process" do
   before { visit signup_path }

   describe "with invalid information" do
     it "should not create new user" do
       expect {click_button "Sign Up"}.should_not change(User, :count)
     end
   end

   describe "with valid information" do
     before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
     end

     it "should create a new user" do
       expect{click_button "Sign Up"}.to change(User, :count).by(1)
     end

   end

 end

end