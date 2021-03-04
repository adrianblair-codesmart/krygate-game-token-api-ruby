# frozen_string_literal: true

require 'grape'

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
    version 'v1', using: :header, vendor: 'krygate'
    format :json
    prefix :api

    # {prefix}/game_tokens/
    resource :game_tokens do
      # get {prefix}/game_tokens/ @returns [Array<GameToken::Model>] as json
      desc 'Get all the available game tokens.'
      get do
        # makes a call to the data Object
        # transfer to game token structure
        # returns JSON
        'All game tokens'
      end

      route_param :id, type: String do
        # get {prefix}/game_tokens/:id @returns [GameToken::Model] as json
        desc 'Get a game token by id.'
        params do
        end
        get do
          # validate params
          # makes a call to the data Object
          # transfer to game token structure
          # returns JSON
          "The id you gave is #{params[:id]}."
          params
        end
      end
    end
  end
end
