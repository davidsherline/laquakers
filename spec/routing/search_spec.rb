require 'rails_helper'

RSpec.describe 'routes for Search', type: :routing do
  it 'routes / to search#index' do
    expect(get('/')).to route_to('search#index')
  end
end
