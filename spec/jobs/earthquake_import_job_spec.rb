require 'rails_helper'

RSpec.describe EarthquakeImportJob, type: :job do
  describe '.perform' do
    context 'with a new record' do
      before(:each) do
        EarthquakeImportJob.perform_now([csv_row])
      end

      context 'with valid data' do
        let(:csv_row) { build(:csv_row) }

        it 'should create an Earthquake' do
          expect(Earthquake.count).to eq(1)
        end
      end

      context 'with invalid data' do
        let(:csv_row) { build(:csv_row, :invalid) }

        it 'should not create an Earthquake' do
          expect(Earthquake.count).to eq(0)
        end
      end
    end

    context 'with an old record' do
      let(:old_record) { build(:csv_row) }

      before(:each) do
        EarthquakeImportJob.perform_now([old_record])
        EarthquakeImportJob.perform_now([new_record])
      end

      context 'with the same data' do
        let(:new_record) { old_record }

        it 'should update the Earthquake' do
          expect(Earthquake.count).to eq(1)
        end
      end

      context 'with updated data' do
        context 'with valid data' do
          let(:now) { Time.now }
          let(:new_record) { build(:csv_row, updated: now) }

          it 'should update the Earthquake' do
            expect(Earthquake.count).to eq(1)
            expect(Earthquake.first.updated_at).to eq(now)
          end
        end

        context 'with invalid data' do
          let(:old_record) { build(:csv_row, mag: 2) }
          let(:new_record) { build(:csv_row, :invalid, mag: 1) }

          it 'should not update the Earthquake' do
            expect(Earthquake.count).to eq(1)
            expect(Earthquake.first.magnitude).to eq(2)
          end
        end
      end
    end

    context 'with one valid and one invalid record' do
      let(:valid_csv_row) { build(:csv_row) }
      let(:invalid_csv_row) { build(:csv_row, :invalid) }

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
