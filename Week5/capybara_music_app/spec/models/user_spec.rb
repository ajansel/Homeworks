require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe '#is_password?' do
    it 'should return true when given the correct password' do
      user = User.new(email: 'aj@gmail.com', password: '123456')
      expect(user.is_password?('123456')).to be(true)
    end
  end

  describe '#reset_session_token!' do
    it 'should reset the session token' do
      user = User.find_by(email: 'aj@gmail.com')
      session_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).to_not eq(session_token)
    end
  end

  describe '::find_by_credentials?' do
    it 'should return the correct user' do
      user = User.find_by(email: 'aj@gmail.com')
      expect(User.find_by_credentials('aj@gmail.com', '123456')).to eq(user)
    end
  end
end
