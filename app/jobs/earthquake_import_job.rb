class EarthquakeImportJob < ApplicationJob
  queue_as :default

  def perform(csv_chunk)
    csv_chunk.each do |row|
      earthquake = EarthquakeTranslator.new(row).to_earthquake
      earthquake.save
    end
  end
end
