class ReminderEmailJob
  include Sidekiq::Worker

  def perform(subscription_id, time_to_send)
    subscription = Subscription.find(subscription_id)
    EmailReminderService.new(subscription).send_reminder
  end
end
