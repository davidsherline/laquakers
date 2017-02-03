class EarthquakeImportJob < ApplicationJob
  queue_as :default

  def perform(csv_chunk)
    csv_chunk.each do |row|
      EarthquakeTranslator.new(row).to_earthquake.save
    end
  end
end
