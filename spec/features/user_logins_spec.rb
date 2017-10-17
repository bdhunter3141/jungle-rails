require 'rails_helper'

RSpec.feature "Visitor that is registered logs in", type: :feature, js: true do
  # SETUP
  before :each do
    User.create!({
      first_name: 'Larry',
      last_name: 'Robertsons',
      email: 'larry@larryandsons.com',
      password: 'larry649',
      password_confirmation: 'larry649'
      })
  end

  scenario "The user is logged in and their name is added to the Nav Bar" do
    # ACT
    visit '/login'
    fill_in 'email', with: 'larry@larryandsons.com'
    fill_in 'password', with: 'larry649'
    page.find_button('Login').click

    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_text('Welcome, Larry')
  end
end
