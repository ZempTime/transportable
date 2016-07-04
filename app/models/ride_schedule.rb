class RideSchedule < ApplicationRecord
  belongs_to :travel_method
  has_one :week, dependent: :destroy

  validates :starts_at, :interval_minutes, presence: true
end
