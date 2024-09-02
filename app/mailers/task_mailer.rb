class TaskMailer < ApplicationMailer
  default from: 'no-reply@taskmanager.com'

  def overdue_notification
    @task = params[:task]
    mail(to: @task.user.email, subject: 'Task Overdue Notification')
  end
end
