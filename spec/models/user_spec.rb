require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    subject { FactoryBot.build(:user) }

    it { is_expected.to have_secure_password }

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_length_of(:first_name).is_at_least(2).is_at_most(50) }

    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_length_of(:last_name).is_at_least(2).is_at_most(50) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to allow_value('test@example.com').for(:email) }

    describe 'password' do
      it 'is invalid when password is not present' do
        user = build(:user, password: nil)
        expect(user).to_not be_valid
        expect(user.errors.messages[:password]).to include("can't be blank")
      end

      it 'is invalid when password is too short' do
        user = build(:user, password: 'Short1!')
        expect(user).to_not be_valid
        expect(user.errors.messages[:password]).to include('is too short (minimum is 8 characters)')
      end

      it 'is invalid without a lowercase letter' do
        user = build(:user, password: 'TEST1234!')
        expect(user).to_not be_valid
        expect(user.errors.messages[:password]).to include('must include at least one lowercase letter, one uppercase letter, one digit, and one special character')
      end

      it 'is invalid without an uppercase letter' do
        user = build(:user, password: 'test1234!')
        expect(user).to_not be_valid
        expect(user.errors.messages[:password]).to include('must include at least one lowercase letter, one uppercase letter, one digit, and one special character')
      end

      it 'is invalid without a digit' do
        user = build(:user, password: 'TestPassword!')
        expect(user).to_not be_valid
        expect(user.errors.messages[:password]).to include('must include at least one lowercase letter, one uppercase letter, one digit, and one special character')
      end

      it 'is invalid without a special character' do
        user = build(:user, password: 'Test12345')
        expect(user).to_not be_valid
        expect(user.errors.messages[:password]).to include('must include at least one lowercase letter, one uppercase letter, one digit, and one special character')
      end
    end
  end
end

