require 'rails_helper'
require 'spec_helper'

RSpec.describe 'Users API', type: :request do
  # initialize test data 
  let!(:users) { create_list(:user, 10, league_id: 1310767) }
  let(:user_id) { users.first.id }

  describe 'GET /users/:league_id/:year' do
    # make HTTP get request before each example
    before { get '/users/1310767/2018' }

    it 'returns users' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/:league_id/:year/:id' do
    before { get "/users/1310767/2018/#{user_id}" }

    context 'when the record exists' do
      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(200)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end
end