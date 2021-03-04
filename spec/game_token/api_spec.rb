# frozen_string_literal: true

require 'rack/test'

require 'spec_helper'

describe GameToken::Api do
  include Rack::Test::Methods

  def app
    GameToken::Api
  end

  context 'when the GET method is sent to /api/game_tokens/' do
    it 'returns an empty array of game tokens' do
      get '/api/game_tokens'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).not_to be_nil
    end
  end
  context 'when the GET method is sent to /api/game_tokens/:id' do
    it 'returns a game token by id' do
      get '/api/game_tokens/abc123'
      expect(last_response.status).to eq 200
      expect(last_response.body).not_to be_nil
    end
  end
end
