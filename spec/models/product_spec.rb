require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before :each do
      @category = Category.create(name: 'Testing')
      @product = Product.new(
                  name: 'Test Product',
                  description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam auctor bibendum diam eu tincidunt. Praesent scelerisque at purus ut tristique. Morbi pharetra nulla sem, id tincidunt enim vehicula vel. Integer sit amet libero pretium, fringilla ante eu, lobortis leo. Maecenas id pulvinar orci.',
                  category_id: @category.id,
                  quantity: 87,
                  price: 99
      )
    end

    it 'saves to the database' do
      expect(@product.save).to be_truthy
    end

    it 'validates that name is present' do
      @product.name = nil
      @product.save
      product_errors = @product.errors.full_messages
      expect(product_errors).to include("Name can't be blank")
    end

    it 'validates that price is present' do
      @product.price = ''
      @product.save
      product_errors = @product.errors.full_messages
      expect(product_errors).to include('Price is not a number')
    end

    it 'validates that quantity is present' do
      @product.quantity = nil
      @product.save
      product_errors = @product.errors.full_messages
      expect(product_errors).to include("Quantity can't be blank")
    end

    it 'validates that category is present' do
      @product.category = nil
      @product.save
      product_errors = @product.errors.full_messages
      expect(product_errors).to include("Category can't be blank")
    end
  end
end