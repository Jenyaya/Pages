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
        expect { click_button "Sign Up" }.should_not change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a new user" do
        expect { click_button "Sign Up" }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before {
          click_button "Sign Up"
        }
        let(:user) { User.find_by_email('user@example.com') }

        it "should have title with username" do
          page.should have_selector('title', content: user.name)
        end

        it { should have_link('Sign out') }
      end

      describe "followed by signout" do
        let(:user) { User.find_by_email('user@example.com') }
        before {
          click_button "Sign Up"
          click_link "Sign out"
        }

        it { should have_link('Sign in') }
      end

    end

  end


  describe "edit user" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user
    visit edit_user_path(user) }

    describe "edit page" do
      it { should have_selector('h1', content: "Update your profile") }
      it { should have_selector('title', content: "Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "edit user with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end


    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_selector('title', content: new_name) }
      it { should have_selector('div.flash.success') }
      it { should have_link('Sign out', :href => signout_path) }
      specify { user.reload.name.should == new_name }
      specify { user.reload.email.should == new_email }
    end


  end

end