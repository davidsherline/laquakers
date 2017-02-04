class SearchController < ApplicationController
  def index
    @earthquakes = Earthquake.first_ten.between(from, to)
    @end_date = Earthquake.latest_on
    @start_date = Earthquake.earliest_on
  end

  private

  def from
    @from ||= params.fetch(:from, 1.month.ago).to_date
  end

  def to
    @to ||= params.fetch(:to, Date.today).to_date
  end
end
