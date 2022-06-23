require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.new(
      email: Faker::Internet.safe_email,
      password: Faker::Internet.password
    )
  end
  describe 'Associations' do
    it '1, should have many tasks' do
      category = Category.reflect_on_association(:tasks)
      expect(category.macro).to eq(:has_many)
    end
  end

  describe 'Attributes' do
    describe 'name' do
      it '1, must be a string' do
        expect(user.email).to be_a String
      end
      it '2, must not nil' do
        expect(user.email).to_not be_nil
      end

      it '3, must be 1 to 128 characters' do
        expect(user.email.length).to (be <= 128).and(be >= 1)
      end
    end

    describe 'password' do
      it '1, must be a string' do
        expect(user.password).to be_a String
      end
      it '2, must not nil' do
        expect(user.password).to_not be_nil
      end

      it '3, must be 1 to 128 characters' do
        expect(user.password.length).to(be >= 6)
      end
    end
  end
end
