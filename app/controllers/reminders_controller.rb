class RemindersController < ApplicationController
  def recent_reminders
    @reminders = Reminder.where("created_at >= ?", 7.days.ago)
  end
end
