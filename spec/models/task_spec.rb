require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
    it "is valid with all attributes" do
      task = FactoryBot.create(:task)
      expect(task).to be_valid
      expect(task.errors).to be_empty
    end

    it "is invalid without a title" do
      task = FactoryBot.build(:task, title: nil)
      task.valid?
      expect(task.errors[:title]).to include("can't be blank")
    end

    it "is invalid without a status" do
      task = FactoryBot.build(:task, status: nil)
      task.valid?
      expect(task.errors[:status]).to include("can't be blank")
    end

    it "is invalid with a duplicate title" do
      FactoryBot.create(:task, title: "Title1")
      task = FactoryBot.build(:task, title: "Title1")
      task.valid?
      expect(task.errors[:title]).to include("has already been taken")
    end
  end
end
