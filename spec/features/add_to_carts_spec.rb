require 'rails_helper'

RSpec.feature "Visitor clicks Add To Cart button", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
        )
    end
  end

  scenario "The cart total number increases by 1" do
    # ACT
    visit root_path
    page.first('.product').find_link('Add').click

    # DEBUG
    save_screenshot

    # VERIFY
    cart_message = page.find :link, href: '/cart'
    expect(cart_message).to have_text('My Cart (1)')
  end
end