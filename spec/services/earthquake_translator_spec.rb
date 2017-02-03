RSpec.describe EarthquakeTranslator do
  let(:csv_row) { build(:csv_row) }
  let(:earthquake_translator) { EarthquakeTranslator.new(csv_row) }

  describe '#to_earthquake' do
    let(:earthquake) { earthquake_translator.to_earthquake }

    it 'should return an Earthquake' do
      expect(earthquake).to be_an Earthquake
    end

    it 'should have the same id as the CSV row' do
      expect(earthquake.id).to eq(csv_row[:id])
    end

    context 'when the date is different in UTC and PDT' do
      let(:csv_row) { build(:csv_row, time: '2017-02-01 07:00:00 UTC') }

      it 'should have the PDT date in occurred_on' do
        expect(earthquake.occurred_on).to eq('2017-01-31'.to_date)
      end
    end
  end
end
