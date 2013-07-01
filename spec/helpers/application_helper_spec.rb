require 'spec_helper'

describe ApplicationHelper do

  describe 'full_title' do

    it 'should contain the page name' do
      full_title('name').should =~ /name/
    end

    it 'should contain the page base' do
      full_title('name').should =~ /^Search N' Find Electronics Reviews/
    end

    it 'should contain only the base title' do
      full_title('').should_not =~ /\|/
    end
  end
end