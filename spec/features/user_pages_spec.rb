require 'spec_helper'

feature 'Sign-up page' do
  subject {page.html}

  before { visit signup_path}

  scenario {should have_selector('h1',    text: 'Sign-up')}
  scenario {should have_selector('title', text: full_title('Sign-up'))}
end

feature 'Show page' do
  subject {page.html}
  let(:user){FactoryGirl.create(:user)}
  before { visit user_path(user)}

  scenario {should have_selector('h1',    text: user.name)}
  scenario {should have_selector('title', text: full_title(user.name))}
end

feature "sign-up" do

  before {visit signup_path}
  let(:submit) {"Create my account"}

  describe "with invalid information" do
    scenario { expect {click_button submit}.not_to change(User, :count) }

    describe "after submission" do
      before {click_button submit}

      subject { page.html }

      scenario {should have_selector('h1',    text: 'Sign-up')}
      scenario {should have_content('error')}
    end
  end

  describe "with valid information" do
    before do
      fill_in "Name",                   with: "test name"
      fill_in "Email-registration",     with: "test@test.com"
      fill_in "Password-registration",  with: "nirnir"
      fill_in "Password-confirmation-registration", with: "nirnir"
    end

    scenario { expect {click_button submit}.to change(User, :count).by(1) }

    describe "after saving user" do
      before {click_button submit}

      subject { page.html }

      let(:user) {User.find_by_email("test@test.com")}

      scenario {should have_selector('title', text: full_title(user.name))}
      scenario {should have_selector('div.alert.alert-success')}
    end
  end
end