class SearchController < ApplicationController
  def index
    @earthquakes = Earthquake.first_ten.between(from, to)
  end

  private

  def from
    params[:from].try(:to_date) || 30.days.ago
  end

  def to
    params[:to].try(:to_date) || Date.today
  end
end
