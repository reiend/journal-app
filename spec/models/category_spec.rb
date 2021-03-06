require 'rails_helper'

RSpec.describe "Category Model", type: :model do
  let(:category) do
    Category.new(
      name: 'category'
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
        expect(category.name).to be_a String
      end
      it '2, must not nil' do
        expect(category.name).to_not be_nil
      end

      it '3, must be 1 to 128 characters' do
        expect(category.name.length).to (be <= 128).and(be >= 1)
      end
    end
  end
end
