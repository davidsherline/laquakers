class Earthquake < ApplicationRecord
  self.primary_key = 'id'

  def self.earliest_on
    order('occurred_at ASC').pluck('occurred_at').first.try(:to_date)
  end

  def self.latest_on
    order('occurred_at DESC').pluck('occurred_at').first.try(:to_date)
  end

  def self.last_updated_at
    order('updated_at DESC').pluck('updated_at').first
  end
end
