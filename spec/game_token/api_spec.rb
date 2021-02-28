require 'rack/test'

require 'spec_helper'

describe GameToken::Api do
  include Rack::Test::Methods

  def app
    GameToken::Api
  end

  context 'GET /api/game_tokens/' do
    it 'returns an empty array of game tokens' do
      get '/api/game_tokens'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq []
    end
  end
  context 'GET /api/game_tokens/:id' do
    it 'returns a game token by id' do
      game_token = { id: 'abc123' }
      get "/api/game_tokens/#{game_token['id']}"
      expect(last_response.status).to eq 200
      expect(last_response.body).not_to be_nil
    end
  end
end
