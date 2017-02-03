RSpec.describe EarthquakeTranslator do
  let(:csv_row) { build(:csv_row) }
  let(:earthquake_translator) { EarthquakeTranslator.new(csv_row) }

  describe '#id' do
    it 'should return the id' do
      expect(earthquake_translator.id).to eq(csv_row[:id])
    end

    it 'should be a string' do
      expect(earthquake_translator.id).to be_a String
    end
  end

  describe '#to_hash' do
    it 'should return a hash of attributes' do
      expect(earthquake_translator.to_hash).to be_a Hash
    end

    it 'should contain id' do
      expect(earthquake_translator.to_hash).to have_key(:id)
    end

    it 'should contain location' do
      expect(earthquake_translator.to_hash).to have_key(:location)
    end

    it 'should contain magnitude' do
      expect(earthquake_translator.to_hash).to have_key(:magnitude)
    end

    it 'should contain distance' do
      expect(earthquake_translator.to_hash).to have_key(:distance)
    end

    it 'should contain occurred_at' do
      expect(earthquake_translator.to_hash).to have_key(:occurred_at)
    end

    it 'should contain created_at' do
      expect(earthquake_translator.to_hash).to have_key(:created_at)
    end

    it 'should contain updated_at' do
      expect(earthquake_translator.to_hash).to have_key(:updated_at)
    end
  end

  describe '#location' do
    it 'should return the place without digits' do
      expect(earthquake_translator.location).to_not match(/\d/)
    end

    it 'should be a string' do
      expect(earthquake_translator.location).to be_a String
    end
  end

  describe '#magnitude' do
    it 'should return the mag' do
      expect(earthquake_translator.magnitude).to eq(csv_row[:mag])
    end

    it 'should be a float' do
      expect(earthquake_translator.magnitude).to be_a Float
    end
  end

  describe '#distance' do
    it 'should return a float' do
      expect(earthquake_translator.distance).to be_a Float
    end
  end

  describe '#occurred_at' do
    it 'should return the time' do
      expect(earthquake_translator.occurred_at).to eq(csv_row[:time].to_time)
    end

    it 'should be a time' do
      expect(earthquake_translator.occurred_at).to be_a Time
    end
  end

  describe '#created_at' do
    it 'should return the time' do
      expect(earthquake_translator.created_at).to eq(csv_row[:time].to_time)
    end

    it 'should be a time' do
      expect(earthquake_translator.created_at).to be_a Time
    end
  end

  describe '#updated_at' do
    it 'should return the updated' do
      expect(earthquake_translator.updated_at).to eq(csv_row[:updated].to_time)
    end

    it 'should be a time' do
      expect(earthquake_translator.updated_at).to be_a Time
    end
  end
end
