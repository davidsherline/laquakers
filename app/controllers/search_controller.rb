class SearchController < ApplicationController
  include Datable

  def index
    @earthquakes = Earthquake.first_ten.between(from, to)
  end
end
