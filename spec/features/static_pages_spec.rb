require 'spec_helper'

feature 'Home page' do
  subject {page.html}

  before { visit root_path}

  scenario {should have_selector('h1',    text: 'Search Something')}
  scenario {should have_selector('title', text: full_title(''))}
end

feature 'About page' do
  subject {page.html}

  before { visit about_path}

  scenario {should have_selector('h1',    text: 'About')}
  scenario {should have_selector('title', text: full_title('About'))}
end

feature 'Check links' do
  subject { page.html }

  before { visit root_path }

  scenario do
    click_link 'About'
    should have_selector('title', text: full_title('About'))
  end

  scenario do
    click_link 'snfer'
    should have_selector('title', text: full_title(''))
  end

  #scenario do
  #  click_link 'Cameras'
  #  should have_selector('title', text: full_title('Cameras'))
  #end
  #
  #scenario do
  #  click_link 'TVs'
  #  should have_selector('title', text: full_title('TVs'))
  #end
  #
  #scenario do
  #  click_link 'Laptops'
  #  should have_selector('title', text: full_title('Laptops'))
  #end
end
