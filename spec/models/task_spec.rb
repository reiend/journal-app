require 'rails_helper'

RSpec.describe "Task Model", type: :model do
  let(:task) do
    Task.new(
      name: 'task1',
      description: 'description',
      deadline: DateTime.now + 24.hour
    )
  end

  describe 'Associations' do
    it '1, should belongs to category' do
      task = Task.reflect_on_association(:category)
      expect(task.macro).to eq(:belongs_to)
    end
  end

  describe 'Attributes' do
    describe 'name' do
      it '1, must be a string' do
        expect(task.name).to be_a String
      end
      it '2, must not nil' do
        expect(task.name).to_not be_nil
      end

      it '3, must be 1 to 128 characters' do
        expect(task.name.length).to (be <= 128).and(be >= 1)
      end
    end

    describe 'description' do
      it '1, must be a string' do
        expect(task.description).to be_a String
      end
      it '2, must not nil' do
        expect(task.description).to_not be_nil
      end

      it '3, must be 1 to 256 characters' do
        expect(task.description.length).to (be <= 256).and(be >= 1)
      end
    end

    describe 'deadline' do
      it '1, must be instance of TimeWithZone  ' do
        expect(task.deadline).to be_instance_of ActiveSupport::TimeWithZone
      end
      it '2, must have a present datetime' do
        expect(task.deadline).to(be > DateTime.now)
      end
    end
  end
end
