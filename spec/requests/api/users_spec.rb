require 'rails_helper'
require 'spec_helper'

RSpec.describe 'Users API', type: :request do
  # create test users
  let!(:users) { create_list(:user, 10, league_id: 1310767) }
  let(:user_id) { users.first.id }

  describe 'GET users valid request /api/users/:league_id' do
    # make HTTP get request before each example
    before { get '/api/users/1310767' }
    
    it 'returns users' do
      # Note `json` is a custom helper to parse JSON responses
      response.body
      expect(json).not_to be_empty
      expect(json.size).to eq(13)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
  
  describe 'GET users invalid year 2019 /api/users/:league_id/:year' do
    # make HTTP get request before each example
    before { get '/api/users/1310767/2019' }
    
    it 'returns proper error message and code' do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
      expect(json['status']).to eq('error')
      expect(json['code']).to eq(3000)
      expect(json['message']).to eq('This is not a valid year for this league.')
    end
  end
  
  describe 'GET users invalid id 999999999 /api/users/:league_id/:year' do
    # make HTTP get request before each example
    before { get '/api/users/999999999/2018' }
    
    it 'returns proper error message and code' do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
      expect(json['status']).to eq('error')
      expect(json['code']).to eq(3001)
      expect(json['message']).to eq('This is not a valid league_id.')
    end
  end


  describe 'GET /api/users/:league_id/2018' do
    # make HTTP get request before each example
    before { get '/api/users/1310767/2018' }
    
    it 'returns users' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(13)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

end