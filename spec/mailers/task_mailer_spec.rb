require 'rails_helper'

RSpec.describe TaskMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:task) { create(:task, user: user, title: "Overdue Task", due_date: 2.days.ago) }

  describe 'overdue_notification' do
    let(:mail) { TaskMailer.with(task: task).overdue_notification }

    it 'renders the headers' do
      expect(mail.subject).to eq('Task Overdue Notification')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['no-reply@taskmanager.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('<h1>Your task is overdue!</h1>')
      expect(mail.body.encoded).to match("The task \"#{task.title}\" was due on #{task.due_date.strftime('%B %d, %Y')} and has not been marked as completed.")
      expect(mail.body.encoded).to match('Please complete it as soon as possible.')
    end
  end
end
