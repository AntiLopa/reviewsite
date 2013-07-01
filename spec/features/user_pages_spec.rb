require 'spec_helper'

feature "index page" do
  subject {page.html}

  let(:user) { FactoryGirl.create(:user)}

  before(:all) { 30.times { FactoryGirl.create(:user)} }
  after(:all)  { User.delete_all }

  before do
    sign_in user
    visit users_path
  end

  scenario {should have_selector('title', text: 'All users')}
  scenario {should have_selector('h1',    text: 'All users')}

  describe "pagination" do
    scenario{ should have_selector('div.pagination')}

    scenario "should list all users" do
      User.paginate(page: 1).each do |user|
        should have_selector('li>a', text: user.name)
      end
    end
  end

  describe "delete links" do
    scenario {should_not have_link('delete')}

    describe "as an admin user" do
      let(:admin){ FactoryGirl.create(:admin)}

      before do
        sign_in admin
        visit users_path
      end

      scenario { should have_link('delete', href: user_path(User.first))}
      scenario "should be able to delete another user" do
        expect{first(:link, 'delete').click}.to change(User, :count).by(-1)
      end
      scenario {should_not have_link('delete', href: user_path(admin))}
    end
  end
end
feature 'Sign-up page' do
  subject {page.html}

  before { visit signup_path}

  scenario {should have_selector('h1',    text: 'Sign up')}
  scenario {should have_selector('title', text: full_title('Sign up'))}
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

      scenario {should have_selector('h1',    text: 'Sign up')}
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
      scenario {should have_link('Sign out')}
    end
  end
end

feature "edit" do
  let(:user) { FactoryGirl.create(:user) }
  subject{page.html}

  before do
    sign_in user
    visit edit_user_path(user)
  end

  describe "page" do
    scenario{ should have_selector('h1',    text: 'Update your profile')}
    scenario{ should have_selector('title', text: 'Edit user')}
  end

  describe "with invalid information" do
    before{click_button "Save changes"}

    scenario{ should have_content('error')}
  end

  describe "with valid information" do
    let(:new_name) { "new name"}
    let(:new_email){ "newemail@gmail.com"}
    before do
      fill_in "Name",                       with: new_name
      fill_in "Email-edit",                 with: new_email
      fill_in "Password-edit",              with: user.password
      fill_in "Password-confirmation-edit", with: user.password
      click_button "Save changes"
    end

    scenario{ should have_selector('title', text: new_name)}
    scenario{ should have_link('Sign out', href: signout_path)}
    scenario{ should have_selector('div.alert.alert-success')}
    specify{ user.reload.name.should  == new_name }
    specify{ user.reload.email.should == new_email }
  end
end