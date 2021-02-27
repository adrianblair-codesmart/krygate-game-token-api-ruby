require 'grape-swagger'

require_relative 'game_token/api'

module Root
  class API < Grape::API
    mount GameToken::API
  end
end
