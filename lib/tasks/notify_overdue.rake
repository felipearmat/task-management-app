namespace :tasks do
  desc "Send notifications for overdue tasks"
  task notify_overdue: :environment do
    TaskOverdueNotificationJob.perform_now
  end
end
