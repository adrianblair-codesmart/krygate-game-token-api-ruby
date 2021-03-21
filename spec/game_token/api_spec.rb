# frozen_string_literal: true

require 'rack/test'

require 'spec_helper'

describe GameToken::Api do
  include Rack::Test::Methods

  let(:game_token_base_hash) { build(:game_token_base_hash) }
  let(:game_token_base_array) { create_game_token_base_hash_array }
  let(:game_token_dao) { App::AppContainer.instance.resolve(:game_token_dao) }

  before(:each) do
    allow(App::AppContainer.instance).to receive(:resolve).with(:game_token_dao).and_return(instance_double(GameToken::DataAccessObject))
  end

  def app
    GameToken::Api
  end

  context 'when the GET method is sent to /api/game_tokens/' do
    it 'returns an empty array of game tokens' do
      game_token_query = double("GameTokenQuery")
      allow(game_token_dao).to receive(:query) { game_token_query }
      allow(game_token_dao).to receive(:run).with(game_token_query) { game_token_base_array }

      get '/api/game_tokens'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eql(game_token_base_array.to_json)
    end
  end
  context 'when the GET method is sent to /api/game_tokens/:id' do
    it 'returns a game token by id' do
      allow(game_token_dao).to receive(:find) { game_token_base_hash }

      get "/api/game_tokens/#{game_token_base_hash[:id]}"
      expect(last_response.status).to eq 200
      expect(last_response.body).to eql(game_token_base_hash.to_json)
    end

    it 'returns a 404 when presented with an invalid id' do
      allow(game_token_dao).to receive(:find) { nil }
      expected_error = {"error": "resource with id: #{game_token_base_hash[:id]} could not be found."}

      get "/api/game_tokens/#{game_token_base_hash[:id]}"
      expect(last_response.status).to eq 404
      expect(last_response.body).to eql(expected_error.to_json)
      byebug
    end
  end
end
