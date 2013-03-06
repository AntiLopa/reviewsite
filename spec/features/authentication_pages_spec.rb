require 'spec_helper'

feature  "signin page" do
  subject {page.html}

  before{ visit signin_path }

  scenario { should have_selector('h1',   text: 'Sign in')}
  scenario { should have_selector('title',text: 'Sign in')}
end

feature  "signin" do
  subject {page.html}

  before{ visit signin_path }

  describe "with invalid information" do
    before{ click_button "Sign in"}

    scenario{ should have_selector('title', text: 'Sign in')}
    scenario{ should have_selector('div.alert.alert-error', text: 'Invalid')}

    describe "after visiting another page" do
      before { click_link "About"}

      scenario {should_not have_selector('div.alert.alert-error', text: 'Invalid')}
    end
  end

  describe "with valid information" do
    let(:user) {FactoryGirl.create(:user)}

    before do
      fill_in "Email-signin",     with: user.email
      fill_in "Password-signin",  with: user.password
      click_button "Sign in"
    end

    scenario{ should have_selector('title', text: user.name)}
    scenario{ should have_link(user.name,   href:user_path(user))}
    scenario{ should have_link('Sign out',  href:signout_path)}
    scenario{ should_not have_button('Sing-in/up')}

    describe "followed by signout" do
      before {click_link "Sign out"}
      scenario { should have_button('Sing-in/up')}
    end
  end
end
