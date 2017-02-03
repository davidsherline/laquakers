namespace :earthquake do
  desc 'Import earthquakes from CSV file at earthquake.usgs.gov'
  task import: :environment do
    log = ActiveSupport::Logger.new('log/earthquake_import.log')
    start_time = Time.now
    log.info "Import started at #{start_time}."

    csv_url = 'http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv'
    csv_file = open(csv_url, 'r:utf-8')
    csv_options = { chunk_size: 250 }

    SmarterCSV.process(csv_file, csv_options) do |chunk|
      EarthquakeImportJob.perform_later(chunk)
    end

    end_time = Time.now
    duration = (start_time - end_time) / 1.minute
    log.info "Import finished at #{end_time}."
    log.info "Import duration was #{duration} minutes."
    log.close
  end
end
