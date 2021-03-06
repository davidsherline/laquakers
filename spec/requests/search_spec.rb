require 'rails_helper'

RSpec.describe 'Search', type: :request do
  context 'with no earthquakes in the database' do
    it 'should display an error message' do
      get '/'
      expect(response.body).to_not include(', CA')
    end
  end

  context 'with earthquakes in the database' do
    before(:each) do
      create_list(:earthquake, 5, :today)
    end

    it 'should display the earthquakes' do
      get '/'
      expect(response.body).to include(', CA')
    end
  end
end
