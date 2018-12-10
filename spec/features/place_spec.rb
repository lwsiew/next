require 'rails_helper'

RSpec.feature "Place", type: :feature do
  context 'create new place' do 
    before(:each) do
      visit '/places/new'
      within("form") do
        fill_in 'Name', with: 'john'
      end
    end

    scenario "should be successful" do
      within("form") do
        fill_in 'Address', with: 'abc'
        # fill_in 'Password confirmation', with: 'abc'
      end
      click_button 'Create Place'
      # expect(page).to have_content 'User was successfully created.'
    end

        scenario "should fail" do
      click_button 'Create Place'
      # expect(page).to have_content 'Email can\'t be blank'
    end
  end

end