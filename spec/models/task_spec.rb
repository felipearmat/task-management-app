require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { create(:user) }

  subject {
    described_class.new(
      title: "Test Task",
      description: "This is a test task.",
      priority: 1,
      due_date: 2.days.from_now,
      completed: false,
      user: user
    )
  }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a title" do
      subject.title = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:title]).to include("can't be blank")
    end

    it "is not valid with an empty title" do
      subject.title = ""
      expect(subject).not_to be_valid
      expect(subject.errors[:title]).to include("can't be blank")
    end

    it "is not valid without a due_date" do
      subject.due_date = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:due_date]).to include("can't be blank")
    end

    it "is not valid without a user" do
      subject.user = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:user]).to include("must exist")
    end
  end

  describe "Methods" do
    it "can mark a task as completed with complete!" do
      expect {
        subject.complete!
      }.to change { subject.completed }.from(false).to(true)
    end
  end
end
