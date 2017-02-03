require 'rails_helper'

RSpec.describe EarthquakeImportJob, type: :job do
  describe '.perform' do
    let(:valid_csv_row) { build(:csv_row) }
    let(:invalid_csv_row) { build(:csv_row, :invalid) }

    context 'with a new record' do
      context 'with valid data' do
        it 'should create an Earthquake' do
          expect(EarthquakeImportJob.perform_now([valid_csv_row])).to be true
          expect(Earthquake.count).to eq(1)
        end
      end

      context 'with invalid data' do
        it 'should not create an Earthquake' do
          expect(EarthquakeImportJob.perform_now([invalid_csv_row]))
            .to be false
          expect(Earthquake.count).to eq(0)
        end
      end
    end

    context 'with an old record' do
      before(:each) do
        EarthquakeImportJob.perform_now([valid_csv_row])
      end

      context 'with the same data' do
        it 'should update the Earthquake' do
          expect(EarthquakeImportJob.perform_now([valid_csv_row])).to be true
          expect(Earthquake.count).to eq(1)
        end
      end

      context 'with updated data' do
        context 'with valid data' do
          let(:now) { Time.now }
          let(:updated_csv_row) { build(:csv_row, updated: now) }

          it 'should update the Earthquake' do
            expect(EarthquakeImportJob.perform_now([updated_csv_row]))
              .to be true
            expect(Earthquake.count).to eq(1)
            expect(Earthquake.first.updated_at).to eq(now)
          end
        end

        context 'with invalid data' do
          let(:valid_csv_row) { build(:csv_row, mag: 2) }
          let(:invalid_csv_row) { build(:csv_row, :invalid, mag: 1) }

          it 'should not update the Earthquake' do
            expect(EarthquakeImportJob.perform_now([invalid_csv_row]))
              .to be false
            expect(Earthquake.count).to eq(1)
            expect(Earthquake.first.magnitude).to eq(2)
          end
        end
      end
    end

    context 'with one valid and one invalid record' do
      before(:each) do
        EarthquakeImportJob.perform_now([valid_csv_row, invalid_csv_row])
      end

      it 'should only create a valid record' do
        expect(Earthquake.count).to eq(1)
        expect(Earthquake.first.id).to eq(valid_csv_row[:id])
      end
    end
  end
end
