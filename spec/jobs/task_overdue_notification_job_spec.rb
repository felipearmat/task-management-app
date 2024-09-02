require 'rails_helper'

RSpec.describe TaskOverdueNotificationJob, type: :job do
  let(:user) { create(:user) }
  let!(:overdue_task) { create(:task, user: user, due_date: 2.days.ago, completed: false) }
  let!(:upcoming_task) { create(:task, user: user, due_date: 2.days.from_now, completed: false) }
  let!(:completed_task) { create(:task, user: user, due_date: 2.days.ago, completed: true) }

  before do
    # Clear the queue before running the tests to avoid interference
    Sidekiq::Worker.clear_all
  end

  describe "#perform" do
    it "sends notifications only for overdue tasks" do
      expect {
        TaskOverdueNotificationJob.perform_now
      }.to change { ActionMailer::Base.deliveries.count }.by(1)

      mail = ActionMailer::Base.deliveries.last
      expect(mail.to).to eq([user.email])
      expect(mail.subject).to eq('Task Overdue Notification')
      expect(mail.body.encoded).to include(overdue_task.title)
      expect(mail.body.encoded).not_to include(upcoming_task.title)
      expect(mail.body.encoded).not_to include(completed_task.title)
    end

    it "does not send notifications if there are no overdue tasks" do
      overdue_task.update(completed: true)

      expect {
        TaskOverdueNotificationJob.perform_now
      }.not_to change { ActionMailer::Base.deliveries.count }
    end

    it "enqueues the job" do
      expect {
        TaskOverdueNotificationJob.perform_later
      }.to have_enqueued_job(TaskOverdueNotificationJob).on_queue('default')
    end
  end
end
