require 'rails_helper'
require 'spec_helper'

RSpec.describe 'Teams API', type: :request do
  
  describe 'make index request to teams controller' do
    before { get '/teams/1310767/2018' }

    it 'returns teams' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(13)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'make get team request to teams controller' do
    let!(:teams) { create_list(:team, 10, league_id: 1310767) }
    let(:team_id) { teams.first.id }
    before { get "/teams/1310767/2018/#{Team.first.id}" }

    context 'when the record exists' do
      it 'returns the team' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(Team.first.id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      before { get "/teams/1310767/2018/100" }

      it 'returns status code 404' do
        expect(response).to have_http_status(200)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Team/)
      end
    end
  end
end