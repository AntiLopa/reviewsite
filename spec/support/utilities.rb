include ApplicationHelper
include SessionsHelper

#RSpec::Matchers.define :have_error_message do |message|
#  match do |page|
#    page.should have_selector('div.alert.alert-error', text: 'Invalid')
#  end
#end

def sign_in(user)
  visit signin_path
  fill_in "Email-signin",     with: user.email
  fill_in "Password-signin",  with: user.password
  click_button "Sign in"
end