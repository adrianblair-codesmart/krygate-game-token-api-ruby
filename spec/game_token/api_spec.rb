# frozen_string_literal: true

require 'rack/test'

require 'spec_helper'

describe GameToken::Api do
  include Rack::Test::Methods

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
      expect(JSON.parse(last_response.body)).not_to be_nil
      #        query = @game_token_dao.query
      #         @game_token_dao.run query
    end
  end
  context 'when the GET method is sent to /api/game_tokens/:id' do
    it 'returns a game token by id' do
      #get '/api/game_tokens/abc123'
      #expect(last_response.status).to eq 200
      #expect(last_response.body).not_to be_nil
    end
  end
end
