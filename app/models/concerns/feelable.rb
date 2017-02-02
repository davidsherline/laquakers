module Feelable
  extend ActiveSupport::Concern

  def felt_in_los_angeles?(magnitude, distance)
    magnitude * 100 > distance
  end
end
