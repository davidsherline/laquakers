class SearchController < ApplicationController
  def index
    @earthquakes = Earthquake.first_ten.between(from, to)
  end

  private

  def from
    params.fetch(:from, 30.days.ago).to_date
  end

  def to
    params.fetch(:to, Date.today).to_date
  end
end
