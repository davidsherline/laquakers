module Datable
  extend ActiveSupport::Concern

  included do
    before_action :set_dates
  end

  private

  def set_dates
    @start_date ||= Earthquake.earliest_on
    @end_date ||= Earthquake.latest_on
  end

  def from
    @from ||= params.fetch(:from, @start_date).to_date
  end

  def to
    @to ||= params.fetch(:to, @end_date).to_date
  end
end
