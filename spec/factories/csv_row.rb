FactoryGirl.define do
  factory :csv_row, class: Hash do
    skip_create

    ignore do
      time '2017-02-02T02:35:55.670Z'
      latitude 34.3135
      longitude -118.1071667
      depth 31.67
      mag 1.47
      magType 'ml'
      nst 6
      gap 115
      dmin 0.1558
      rms 0.2
      net 'ci'
      id 'ci37577079'
      updated '2017-02-02T02:39:39.196Z'
      place '14km N of Altadena, CA'
      type 'earthquake'
      horizontalError 1.19
      depthError 1.98
      magError 0.426
      magNst 19
      status 'automatic'
      locationSource 'ci'
      magSource 'ci'
    end

    initialize_with do
      {
        time: time,
        latitude: latitude,
        longitude: longitude,
        depth: depth,
        mag: mag,
        magType: magType,
        nst: nst,
        gap: gap,
        dmin: dmin,
        rms: rms,
        net: net,
        id: id,
        updated: updated,
        place: place,
        type: type,
        horizontalError: horizontalError,
        depthError: depthError,
        magError: magError,
        magNst: magNst,
        status: status,
        locationSource: locationSource,
        magSource: magSource
      }
    end
  end
end
