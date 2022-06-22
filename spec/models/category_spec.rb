require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) do
    Category.new(
      name: 'category'
    )
  end

  describe 'Attributes' do
    describe 'name' do
      it '1, must be a string' do
        expect(Category.name).to be_a String
      end
      it '2, must not nil' do
        expect(Category.name).to_not be_nil
      end

      it '3, must be 1 to 128 characters' do
        expect(Category.name.length).to (be <= 128).and(be >= 1)
      end
    end
  end
end
