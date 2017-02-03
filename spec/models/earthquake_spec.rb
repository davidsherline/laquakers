require 'rails_helper'

RSpec.describe Earthquake, type: :model do
  describe '.between' do
    let(:today) { Date.today }
    let(:yesterday) { Date.yesterday }

    before(:each) do
      create_list(:earthquake, 15, occurred_on: today)
      create_list(:earthquake, 10, occurred_on: yesterday)
      create_list(:earthquake, 5, :epoch)
    end

    context 'when the date today is provided for both from and to' do
      it 'should return only records from today' do
        expect(Earthquake.between(today, today).count).to eq(15)
      end
    end

    context 'when the date yesterday is provided for both from and to' do
      it 'should return only records from yesterday' do
        expect(Earthquake.between(yesterday, yesterday).count).to eq(10)
      end
    end

    context 'when the date from is yesterday and to is today' do
      it 'should return only records from yesterday and today' do
        expect(Earthquake.between(yesterday, today).count).to eq(25)
      end
    end

    context 'when the date is from seven days ago to six days ago' do
      it 'should not return any records' do
        expect(Earthquake.between(7.days.ago, 6.days.ago).count).to eq(0)
      end
    end
  end

  describe '.first_ten' do
    before(:each) do
      create_list(:earthquake, 5, :today)
      create_list(:earthquake, 10, :yesterday)
    end

    it 'should only return ten records' do
      expect(Earthquake.first_ten.count).to eq(10)
    end

    it 'should return the first ten records' do
      expect(Earthquake.first_ten.pluck(:occurred_on).uniq.count).to eq(1)
    end
  end

  describe '.earliest_on' do
    context 'with earthquake records' do
      let!(:earliest) { create(:earthquake, :epoch) }

      before(:each) do
        create_list(:earthquake, 2)
      end

      it 'should return the occurred_on date for the earliest earthquake' do
        expect(Earthquake.earliest_on).to eq(earliest.occurred_on)
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

      it 'should return the occurred_on date for the latest earthquake' do
        expect(Earthquake.latest_on).to eq(latest.occurred_on)
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

  describe '#ensure_felt_in_los_angeles' do
    let(:not_felt) { build(:earthquake, :not_felt) }

    it 'should not save when the earthquake was not felt in Los Angeles' do
      expect(not_felt).to be_invalid
    end
  end
end
