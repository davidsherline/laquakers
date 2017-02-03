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
  end
end
