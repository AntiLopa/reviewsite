require 'spec_helper'

feature "HomePages" do

  before { visit '/home_page/home'}

  scenario do

    #visit '/home_page/home'
    expect(page).to have_content("Home")

  end

end
