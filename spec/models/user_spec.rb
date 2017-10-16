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

    it 'validates that password length is at least 5 characters' do
      @user.password = 'wow'
      @user.save
      user_errors = @user.errors.full_messages
      expect(user_errors).to include("Password is too short (minimum is 5 characters)")
    end
  end

  describe '.authenticate_with_credentials' do

    before :each do
      User.create({
        first_name: 'Larry',
        last_name: 'Robertsons',
        email: 'larry@larryandsons.com',
        password: 'larry649',
        password_confirmation: 'larry649'
        })

      @user_credentials = { email: 'larry@larryandsons.com', password: 'larry649' }
    end

    it 'checks if user is authenticated' do
      valid_user = User.authenticate_with_credentials(@user_credentials[:email], @user_credentials[:password])
      expect(valid_user).to be_truthy
    end

    it 'validates that user exists' do
      user = User.authenticate_with_credentials('bob@smithandsons.com', @user_credentials[:password])
      expect(user).to be_falsey
    end

    it 'checks that password is valid' do
      user = User.authenticate_with_credentials(@user_credentials[:email], 'goodpassword123')
      expect(user).to be_falsey
    end

    it 'validates that password field is present' do
      user = User.authenticate_with_credentials(@user_credentials[:email], '')
      expect(user).to be_falsey
    end

    it 'validates that email field is present' do
      user = User.authenticate_with_credentials('', @user_credentials[:password])
      expect(user).to be_falsey
    end

    it 'accomodates spaces before user email address' do
      user = User.authenticate_with_credentials("  #{@user_credentials[:email]}", @user_credentials[:password])
      expect(user).to be_truthy
    end

    it 'accomodates spaces after user email address' do
      user = User.authenticate_with_credentials("#{@user_credentials[:email]}  ", @user_credentials[:password])
      expect(user).to be_truthy
    end

    it 'allows user emails to not be case sensitive' do
      user = User.authenticate_with_credentials('LARRY@larryandsons.com', @user_credentials[:password])
      expect(user).to be_truthy
    end
  end
end
