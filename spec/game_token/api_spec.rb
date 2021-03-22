# frozen_string_literal: true

require 'rack/test'

require 'spec_helper'

describe GameToken::Api do
  include Rack::Test::Methods

  let(:game_token_base_hash) { build(:game_token_base_hash) }
  let(:game_token) { build(:game_token) }
  let(:game_token_base_array) { create_game_token_base_hash_array }
  let(:game_token_dao) { App::AppContainer.instance.resolve(:game_token_dao) }
  let(:logger_mock) { App::AppLogger.instance }

  before(:each) do
    mock_logger
    allow(App::AppContainer.instance).to receive(:resolve).with(:game_token_dao).and_return(instance_double(GameToken::DataAccessObject))
  end

  def app
    GameToken::Api
  end

  context 'when the GET method is sent to /api/game_tokens/' do
    it 'returns an empty array of game tokens' do
      game_token_query = double('GameTokenQuery')
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

      get "/api/game_tokens/#{game_token_base_hash[:id]}"

      json_response = JSON.parse(last_response.body)

      expect(last_response.status).to eq 404
      expect(json_response).to include('error')
    end
  end

  context 'when the POST method is sent to /api/game_tokens/' do
    context 'with valid parameters' do
      it 'creates a game token' do
        allow(game_token_dao).to receive(:insert) { game_token_base_hash }

        post '/api/game_tokens/', { token_name: game_token.token_name, token_domains: game_token.token_domains }
        expect(last_response.status).to eq 201
        expect(last_response.body).to eql(game_token_base_hash.to_json)
      end
    end
  end

  context 'with a missing token name parameter' do
    it 'returns an array of errors with a 400 response code' do
      post '/api/game_tokens/'

      json_response = JSON.parse(last_response.body)

      expect(last_response.status).to eq 400
      expect(json_response).to include('error')
    end
  end

  context 'with an invalid token name' do
    it 'returns an array of errors with a 400 response code' do
      post '/api/game_tokens/', { token_name: nil }

      json_response = JSON.parse(last_response.body)

      expect(last_response.status).to eq 400
      expect(json_response).to include('error')
    end
  end

  context 'with an invalid token domains' do
    it 'returns an array of errors with a 400 response code' do
      post '/api/game_tokens/', { token_name: game_token.token_name, token_domains: ['bad domain', 'bad domain 2'] }

      json_response = JSON.parse(last_response.body)

      expect(last_response.status).to eq 400
      expect(json_response).to include('errors')
    end
  end

  context 'when a TypeError has occurred' do
    it 'returns an error with a 400 response code' do
      allow(game_token_dao).to receive(:insert).and_raise(TypeError, 'type error test exception.')

      post '/api/game_tokens/', { token_name: game_token.token_name }

      json_response = JSON.parse(last_response.body)

      expect(last_response.status).to eq 400
      expect(json_response).to include('error')
      expect(logger_mock).to have_received(:error)
    end
  end

  context 'when a unexpected error has occurred' do
    it 'returns an error with a 500 response code' do
      allow(game_token_dao).to receive(:insert).and_raise(StandardError, 'type error test exception.')

      post '/api/game_tokens/', { token_name: game_token.token_name }

      json_response = JSON.parse(last_response.body)

      expect(last_response.status).to eq 500
      expect(json_response).to include('error')
      expect(logger_mock).to have_received(:error)
    end
  end
end