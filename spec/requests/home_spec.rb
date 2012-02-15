require 'spec_helper'

describe "Home page" do
  get "/"

  it { should have_selector('h1', content: "Home Page") }
  it { should have_selector('a', content: "Sign Up") }

end