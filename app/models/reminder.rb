class Reminder < ApplicationRecord
  belongs_to :user
  belongs_to :subscription

  validates :message, presence: true
end
