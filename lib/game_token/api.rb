# frozen_string_literal: true

require 'grape'
require 'securerandom'
require 'byebug'


# Namespace for game token related modules and classes
# @author Adrian Blair
module GameToken
  # Class representing the game token API
  #
  # @resource game_tokens "api/game_tokens/"
  # @get get api/game_tokens/ returns Array<{GameToken::Model GameToken::Model}> as json
  # @get get api/game_tokens/:id returns {GameToken::Model GameToken::Model} as json
  #
  # @see https://www.rubydoc.info/github/ruby-grape/grape/Grape/API Grape::API
  class Api < Grape::API
    before do
      @game_token_dao = App::AppContainer.instance.resolve(:game_token_dao)
    end

    version 'v1', using: :header, vendor: 'krygate'
    format :json
    prefix :api

    # {prefix}/game_tokens/
    resource :game_tokens do
      # get {prefix}/game_tokens/ @returns [Array<GameToken::Model>] as json
      desc 'Get all the available game tokens.'
      get do
        query = @game_token_dao.query
        @game_token_dao.run query
      end

      # post {prefix}/game_tokens @returns [Array<GameToken::Model>] as json
      desc 'Create a new game token.'
      params do
        requires :token_name, type: String, allow_blank: false
        optional :token_domains, type: Array[String], default: []
      end
      post do

          params[:token_key] = SecureRandom.uuid

          contract = NewGameTokenContract.new
          result = contract.call(params)

          if (result.errors.count > 0)
            error! result.errors.to_h, 400
          end
          byebug
          model = GameToken::Model.new(result.to_h)
          @game_token_dao.insert(model)
        # https://stackoverflow.com/questions/2239240/use-rackcommonlogger-in-sinatra
        # https://github.com/rack/rack/blob/master/lib/rack/common_logger.rb
        #TODO Add Rescue statement which logs error and returns a generic error message.
      end

      route_param :id, type: String do
        # get {prefix}/game_tokens/:id @returns [GameToken::Model] as json
        desc 'Get a game token by id.'
        params do
        end
        get do
          @game_token_dao.find(params[:id])
        end
      end
    end
  end
end
