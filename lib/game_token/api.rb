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
      rescue StandardError => e
        App::AppLogger.instance.error("#{e.class}: #{e.message} \n\t#{e.backtrace.join("\n\t")}")
        error!({error: 'An unexpected error occurred.'}, 500)
      end

      # post {prefix}/game_tokens @returns [Array<GameToken::Model>] as json
      desc 'Create a new game token.'
      params do
        requires :token_name, type: String, allow_blank: false
        optional :token_domains, type: Array[String], default: []
      end
      post do
        contract = NewGameTokenContract.new
        result = contract.call(params)

        error!({errors: result.errors.to_h}, 400) if result.errors.count.positive?

        game_token_hash = result.to_h
        game_token_hash[:id] = SecureRandom.uuid
        model = GameToken::Model.new(game_token_hash)

        @game_token_dao.insert([model])
      rescue App::CustomErrors::ItemAlreadyExistsError => e
        App::AppLogger.instance.warn("#{e.class}: #{e.message} \n\t#{e.backtrace.join("\n\t")}")
        error!({error: e.message}, 400)
      rescue TypeError => e
        App::AppLogger.instance.error("#{e.class}: #{e.message} \n\t#{e.backtrace.join("\n\t")}")
        error!({error: e.message}, 400)
      rescue StandardError => e
        App::AppLogger.instance.error("#{e.class}: #{e.message} \n\t#{e.backtrace.join("\n\t")}")
        error!({error: 'An unexpected error occurred.'}, 500)
      end

      route_param :id, type: String do
        # get {prefix}/game_tokens/:id @returns [GameToken::Model] as json
        desc 'Get a game token by id.'
        params do
        end
        get do
          item = @game_token_dao.find(params[:id])
          error! "resource with id: #{params[:id]} could not be found.", 404 if item.blank?
          item
        rescue StandardError => e
          App::AppLogger.instance.error("#{e.class}: #{e.message} \n\t#{e.backtrace.join("\n\t")}")
          error!({error: 'An unexpected error occurred.'}, 500)
        end

        # put {prefix}/game_tokens/:id @returns [Array<GameToken::Model>] as json
        desc 'Update an existing game token.'
        params do
          requires :token_name, type: String, allow_blank: false
          optional :token_domains, type: Array[String], default: []
        end
        put do
          contract = ExistingGameTokenContract.new
          result = contract.call(params)

          error!({errors: result.errors.to_h}, 400) if result.errors.count.positive?

          game_token_hash = result.to_h
          model = GameToken::Model.new(game_token_hash)

          @game_token_dao.update([model])
        rescue App::CustomErrors::ItemDoesNotExistError => e
          App::AppLogger.instance.warn("#{e.class}: #{e.message} \n\t#{e.backtrace.join("\n\t")}")
          error!({error: e.message}, 404)
        rescue TypeError => e
          App::AppLogger.instance.error("#{e.class}: #{e.message} \n\t#{e.backtrace.join("\n\t")}")
          error!({error: e.message}, 400)
        rescue StandardError => e
          App::AppLogger.instance.error("#{e.class}: #{e.message} \n\t#{e.backtrace.join("\n\t")}")
          error!({error: 'An unexpected error occurred.'}, 500)
        end


        # delete {prefix}/game_tokens/:id
        desc 'Delete an existing game token.'
        params do

        end
        delete do
          @game_token_dao.delete([params[:id]])
          status :no_content
        rescue StandardError => e
          App::AppLogger.instance.error("#{e.class}: #{e.message} \n\t#{e.backtrace.join("\n\t")}")
          error!({error: 'An unexpected error occurred.'}, 500)
        end
      end
    end
  end
end
