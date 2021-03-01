# frozen_string_literal: true

require 'grape'

# Namespace for game token related modules and classes
# @author Adrian Blair
module GameToken
  # Class representing the game token API
  #
  # @see Grape::API
  # @resource game_tokens "api/game_tokens"
  # @get "" returns game tokens stored in the data store
  class Api < Grape::API
    version 'v1', using: :header, vendor: 'krygate'
    format :json
    prefix :api

    resource :game_tokens do
      desc 'Get all the available game tokens.'
      get do
        'Hello. This is the Krygate Game Token API.'
      end

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
