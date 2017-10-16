require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    before :each do

      User.create({
        first_name: 'Larry',
        last_name: 'Robertsons',
        email: 'larry@larryandsons.com',
        password: 'larry649',
        password_confirmation: 'larry649'
        })

      @user = User.new({
        first_name: 'Bob',
        last_name: 'Smith',
        email: 'bob@smithandsons.com',
        password: 'bobby647',
        password_confirmation: 'bobby647'
        })
    end

    it 'saves to the database' do
      expect(@user.save).to be_truthy
    end

    it 'validates that the password and password confirmation fields match' do
      @user.password_confirmation = 'wilson'
      @user.save
      user_errors = @user.errors.full_messages
      expect(user_errors).to include("Password confirmation doesn't match Password")
    end

    it 'validates that password field is present' do
      @user.password = nil
      @user.save
      user_errors = @user.errors.full_messages
      expect(user_errors).to include("Password can't be blank")
    end

    it 'validates that emails are unique' do
      @user.email = 'larry@larryandsons.com'
      @user.save
      user_errors = @user.errors.full_messages
      expect(user_errors).to include("Email has already been taken")
    end

    it 'validates that emails are not case sensitive' do
      @user.email = 'LARRY@larryandsons.com'
      @user.save
      user_errors = @user.errors.full_messages
      expect(user_errors).to include("Email has already been taken")
    end

    it 'validates that first_name field is present' do
      @user.first_name = nil
      @user.save
      user_errors = @user.errors.full_messages
      expect(user_errors).to include("First name can't be blank")
    end

    it 'validates that last_name field is present' do
      @user.last_name = nil
      @user.save
      user_errors = @user.errors.full_messages
      expect(user_errors).to include("Last name can't be blank")
    end

    it 'validates that email field is present' do
      @user.email = nil
      @user.save
      user_errors = @user.errors.full_messages
      expect(user_errors).to include("Email can't be blank")
    end
  end
end

# validates :first_name, presence: true
# validates :last_name, presence: true
# validates :email, presence: true, uniqueness: true
# validates :password_digest, presence: true
