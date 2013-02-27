require 'spec_helper'

#feature 'Static Pages' do

  feature 'Home page' do

    before { visit root_path}

    scenario {expect(page).to have_selector('h1', text: 'Search Something')}
    scenario {expect(page).to have_selector('title', text: full_title(''))}

  end

  feature 'Home page' do

    before { visit about_path}

    scenario {expect(page).to have_selector('h1', text: 'About')}
    scenario {expect(page).to have_selector('title', text: full_title('About'))}

  end

#end
