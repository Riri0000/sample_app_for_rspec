require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
    it "is valid with all attributes" do
      task = build(:task)
      expect(task).to be_valid
      expect(task.errors).to be_empty
    end

    it "is invalid without a title" do
      task_without_title = build(:task, title: nil)
      task_without_title.valid?
      expect(task_without_title.errors[:title]).to include("can't be blank")
    end

    it "is invalid without a status" do
      task_without_status = build(:task, status: nil)
      task_without_status.valid?
      expect(task_without_status.errors[:status]).to include("can't be blank")
    end

    it "is invalid with a duplicate title" do
      FactoryBot.create(:task, title: "Title1")
      task_with_duplicated_title = build(:task, title: "Title1")
      task_with_duplicated_title.valid?
      expect(task_with_duplicated_title.errors[:title]).to include("has already been taken")
    end
  end
end
