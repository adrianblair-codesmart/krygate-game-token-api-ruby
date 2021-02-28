require 'grape'

module GameToken
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
