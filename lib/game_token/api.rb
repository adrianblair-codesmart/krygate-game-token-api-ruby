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
        'Hello. This is the Krygate Game Token API.'
      end

      # get {prefix}/game_tokens/:id @returns [GameToken::Model] as json
      desc 'Get a game token by id.'
      params do
        requires :id, type: String, desc: 'Game Token ID.'
      end
      get ':id' do
        return "The id you gave is #{params[:id]}."
      end
    end
  end
end
