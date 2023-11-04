class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :reminders, dependent: :destroy
  has_many :renewal_dates

  validates :name, presence: true
  validates :cost, presence: true
  validates :frequency, presence: true
  validates :category_id, presence: true
  validates :start_date, presence: true

  def transaction_date
    calculated_date = case frequency
                      when 'Weekly'
                        start_date + ((Date.today - start_date).to_i / 7) * 7
                      when 'Monthly'
                        start_date + ((Date.today.year * 12 + Date.today.month) - (start_date.year * 12 + start_date.month)).months
                      when 'Yearly'
                        start_date + (Date.today.year - start_date.year).years
                      end

    # If the calculated date is in the future, use the last calculated date
    last_calculated_date = calculated_date

    Date.today > calculated_date ? calculated_date : last_calculated_date
  end

  def calculated_renewal_date
    return start_date if start_date.present? && start_date > Date.today

    calculated_date = transaction_date
    today = Date.today

    case frequency
    when 'Weekly'
      # Add 1 week to the transaction date until it's in the future
      calculated_date += 1.week while calculated_date <= today
    when 'Monthly'
      # Add 1 month to the transaction date until it's in the future
      calculated_date += 1.month while calculated_date <= today
    when 'Yearly'
      # Add 1 year to the transaction date until it's in the future
      calculated_date += 1.year while calculated_date <= today
    end

    calculated_date
  end

  def all_renewal_dates
    renewals = []
    current_date = start_date

    case frequency
    when 'Monthly'
      renewals << current_date
      11.times do
        current_date += 1.month
        renewals << current_date
      end
    when 'Yearly'
      renewals << current_date
      1.times do
        current_date += 1.year
        renewals << current_date
      end
    when 'Weekly'
      renewals << current_date
      51.times do # 52 weeks in a year
        current_date += 1.week
        renewals << current_date
      end
    end

    renewals
  end

  after_create :schedule_email_reminder

  def schedule_email_reminder
    return unless calculated_renewal_date == Date.today + 1.day

    EmailReminderService.new(self).send_reminder
  end

  def schedule_email_reminders
    all_renewal_dates.each do |renewal_date|
      ReminderEmailJob.perform_async(id, (renewal_date.to_time.to_i - 1.day.to_i))
    end
  end
end
