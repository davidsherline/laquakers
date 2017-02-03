class EarthquakeTranslator
  PLACE_SEPARATOR_REGEX = / of /
  LA_COORDINATES = [34.0522, -118.2437].freeze

  def initialize(args)
    @time = args[:time]
    @latitude = args[:latitude]
    @longitude = args[:longitude]
    @mag = args[:mag]
    @id = args[:id]
    @updated = args[:updated]
    @place = args[:place]
  end

  def to_earthquake
    earthquake = Earthquake.find_or_initialize_by(id: id)
    earthquake.assign_attributes(to_hash)
    earthquake
  end

  def to_earthquake!
    to_earthquake.save
  end

  private

  def to_hash
    {
      id: id,
      location: location,
      magnitude: magnitude,
      distance: distance,
      occurred_at: occurred_at,
      created_at: created_at,
      updated_at: updated_at
    }
  end

  def id
    @id.to_s
  end

  def location
    @place.split(PLACE_SEPARATOR_REGEX).last
  end

  def magnitude
    @mag.to_f
  end

  def distance
    @distance ||= Haversine.distance(LA_COORDINATES, coordinates).to_miles
  end

  def occurred_at
    @time.to_time
  end

  def created_at
    occurred_at
  end

  def updated_at
    @updated.to_time
  end

  def coordinates
    [@latitude.to_f, @longitude.to_f]
  end
end
