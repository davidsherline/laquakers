require 'rails_helper'

RSpec.describe Earthquake, type: :model do
  describe '.earliest_on' do
    context 'with earthquake records' do
      let!(:earliest) { create(:earthquake, :epoch) }

      before(:each) do
        create_list(:earthquake, 2)
      end

      it 'should return the occurred_at date for the earliest earthquake' do
        expect(Earthquake.earliest_on).to eq(earliest.occurred_at.to_date)
      end
    end

    context 'with no earthquake records' do
      it 'should return nil' do
        expect(Earthquake.earliest_on).to be_nil
      end
    end
  end

  describe '.latest_on' do
    context 'with earthquake records' do
      let!(:latest) { create(:earthquake, :today) }

      before(:each) do
        create_list(:earthquake, 2)
      end

      it 'should return the occurred_at date for the latest earthquake' do
        expect(Earthquake.latest_on).to eq(latest.occurred_at.to_date)
      end
    end

    context 'with no earthquake records' do
      it 'should return nil' do
        expect(Earthquake.latest_on).to be_nil
      end
    end
  end

  describe '.last_updated_at' do
    context 'with earthquake records' do
      let!(:latest) { create(:earthquake, :today) }

      before(:each) do
        create_list(:earthquake, 2)
      end

      it 'should return the updated_at date for the most recent earthquake' do
        expect(Earthquake.last_updated_at).to eq(latest.updated_at)
      end
    end

    context 'with no earthquake records' do
      it 'should return nil' do
        expect(Earthquake.last_updated_at).to be_nil
      end
    end
  end
end
