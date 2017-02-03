namespace :earthquake do
  desc 'Import earthquakes from CSV file at earthquake.usgs.gov'
  task import: :environment do
    log = ActiveSupport::Logger.new('log/earthquake_import.log')
    start_time = Time.now
    log.info "Import started at #{start_time}."

    csv_url = 'http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv'
    csv_file = open(csv_url, 'r:utf-8')
    csv_options = { chunk_size: 250 }

    puts 'Beginning import of CSV data from:'
    puts csv_url

    SmarterCSV.process(csv_file, csv_options) do |chunk|
      EarthquakeImportJob.perform_later(chunk)
    end

    puts 'Import complete.'

    end_time = Time.now
    duration = (end_time - start_time) / 1.minute
    log.info "Import finished at #{end_time}."
    log.info "Import duration was #{duration} minutes."
    log.close
  end
end
