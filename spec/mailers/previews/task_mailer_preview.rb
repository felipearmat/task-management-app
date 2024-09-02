# Preview all emails at http://localhost:3000/rails/mailers/task_mailer_mailer
class TaskMailerPreview < ActionMailer::Preview
  def overdue_notification
    user = User.first || User.new(email: "user@example.com")
    task = Task.first || Task.new(title: "Overdue Task", user: user, due_date: Date.yesterday)

    TaskMailer.with(task: task).overdue_notification
  end
end
