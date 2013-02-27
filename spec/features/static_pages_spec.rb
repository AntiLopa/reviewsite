require 'spec_helper'

#feature 'Static Pages' do


  feature 'Home page' do
    subject {page.html}

    before { visit root_path}

    scenario {should have_selector('h1', text: 'Search Something')}
    scenario {should have_selector('title', text: full_title(''))}

  end

  feature 'Home page' do
    subject {page.html}

    before { visit about_path}

    scenario {should have_selector('h1', text: 'About')}
    scenario {should have_selector('title', text: full_title('About'))}

  end

#end
