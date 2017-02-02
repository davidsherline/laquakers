class Earthquake < ApplicationRecord
  self.primary_key = 'id'

  validate :ensure_felt_in_los_angeles

  def self.earliest_on
    order('occurred_at ASC').pluck('occurred_at').first.try(:to_date)
  end

  def self.latest_on
    order('occurred_at DESC').pluck('occurred_at').first.try(:to_date)
  end

  def self.last_updated_at
    order('updated_at DESC').pluck('updated_at').first
  end

  private

  def ensure_felt_in_los_angeles
    errors.add(:magnitude, 'must be felt in Los Angeles') unless
      felt_in_los_angeles?
  end

  def felt_in_los_angeles?
    (magnitude * 100) > distance
  end
end
