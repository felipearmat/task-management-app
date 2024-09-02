class TaskOverdueNotificationJob < ApplicationJob
  queue_as :default

  def perform
    # Find tasks that are overdue and not completed
    overdue_tasks = Task.where("due_date < ? AND completed = ?", Time.current, false)

    overdue_tasks.find_each do |task|
      # Send notification via email
      TaskMailer.with(task: task).overdue_notification.deliver_now

      # Add other messaging channels here, like SMS, if needed
    end
  end
end
