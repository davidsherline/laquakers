class Earthquake < ApplicationRecord
  include Feelable

  self.primary_key = 'id'

  validate :ensure_felt_in_los_angeles

  scope :between, ->(from, to) { where(occurred_on: from..to) }
  scope :first_ten, -> { order('occurred_on ASC').first(10) }

  def self.earliest_on
    order('occurred_on ASC').pluck('occurred_on').first
  end

  def self.latest_on
    order('occurred_on DESC').pluck('occurred_on').first
  end

  def self.last_updated_at
    order('updated_at DESC').pluck('updated_at').first
  end

  private

  def ensure_felt_in_los_angeles
    errors.add(:magnitude, 'must be felt in Los Angeles') unless
      felt_in_los_angeles?(magnitude, distance)
  end
end
