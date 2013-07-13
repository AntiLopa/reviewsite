require 'spec_helper'

feature  "signin page" do
  subject {page}

  before{ visit signin_path }

  scenario { should have_selector('h1',   text: 'Sign in')}
  scenario { should have_title('Sign in')}
  #scenario { should have_selector('title', text: full_title('Sign in'))}
end

feature  "signin" do
  subject {page}

  before{ visit signin_path }

  describe "with invalid information" do
    before{ click_button "Sign in"}

    scenario{ should have_title('Sign in')}
    #scenario {should have_selector('title', text: full_title('Sign in'))}
    scenario{ should have_selector('div.alert.alert-error', text: 'Invalid')}

    describe "after visiting another page" do
      before { click_link "About"}

      scenario {should_not have_selector('div.alert.alert-error', text: 'Invalid')}
    end
  end

  describe "with valid information" do
    let(:user) {FactoryGirl.create(:user)}

    before {sign_in_utl user}

    scenario{ should have_title(user.name)}
    scenario{ should have_link(user.name,  href:user_path(user))}
    scenario{ should have_link('Sign out', href:signout_path)}
    scenario{ should have_link('Users',    href:users_path)}
    scenario{ should_not have_button('Sing-in/up')}
    scenario do
      click_link user.name
      should have_link('edit', href: edit_user_path(user))
    end

    describe "followed by signout" do
      before {click_link "Sign out"}
      scenario { should have_button('Sing-in/up')}
    end
  end

  describe "authorization" do
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user)}

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email-signin",     with: user.email
          fill_in "Password-signin",  with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do
          scenario{should have_title('Edit user')}
        end

        describe "when wigning in again" do
          before do
            click_link "Sign out"
            click_link "Sign in"
            fill_in "Email-signin",     with: user.email
            fill_in "Password-signin",  with: user.password
            click_button "Sign in"
          end

          scenario{ should have_title(user.name)}
        end
      end

      describe "in the users controller" do
        describe "visiting the edit page" do
          before{ visit edit_user_path(user)}
          scenario{ should have_title('Sign in')}
          scenario{ should have_selector('div.alert.alert-notice')}
        end

        describe "visiting the user index" do
          before {visit users_path}
          scenario{ should have_title('Sign in')}
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user)}
      let(:wrong_user) { FactoryGirl.create(:user, name: "just wrong name", email: "wrong@example.com")}
      before { sign_in_utl user}

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user)}
        scenario{ should_not have_title('Edit user')}
      end
    end
  end
end
