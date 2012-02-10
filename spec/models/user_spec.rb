require 'spec_helper'

describe User do

  before { @user = User.new(name: "Example User", email: "user@example.com",
                            password: "password", password_confirmation: "password") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when name is too short" do
    before { @user.name = "a" * 2 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    invalid_addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    invalid_addresses.each do |invalid_address|
      before { @user.email = invalid_address }
      it { should_not be_valid }
    end
  end

  describe "when email format is valid" do
    valid_addresses = %w[user@foo.com A_USER@f.b.org frst.lst@foo.jp a+b@baz.cn]
    valid_addresses.each do |valid_address|
      before { @user.email = valid_address }
      it { should be_valid }
    end
  end


  describe "when email address is already exists" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when email case sensitive address is already exists" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  # passwords
  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end

  end


end

#before(:each) do
#  @testuser = {:name => "Example User", :email => "user@example.com"}
#end
#
#it "should create a new instance given valid attributes" do
#  User.create!(@testuser)
#end
#
#it "should require a name" do
#  no_name_user = User.new(@testuser.merge(:name => ""))
#  no_name_user.should_not be_valid
#end
#
#it "should require an email address" do
#  no_email_user = User.new(@testuser.merge(:email => ""))
#  no_email_user.should_not be_valid
#end
#
#
#it "should reject names that are too long" do
#  long_name = "a" * 51
#  long_name_user = User.new(@testuser.merge(:name => long_name))
#  long_name_user.should_not be_valid
#end
#
# it "should reject names that are too short" do
#  short_name = "a" * 2
#  short_name_user = User.new(@testuser.merge(:name => short_name))
#  short_name_user.should_not be_valid
#end

