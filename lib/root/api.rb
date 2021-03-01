# frozen_string_literal: true

require 'grape'

# Namespace for game token related modules and classes
# @author Adrian Blair
module Root
  # Class representing the root API which mounts other related APIs
  #
  # @mount {GameToken::Api} mounts the game token API
  #
  # @see GameToken::Api
  # @see https://www.rubydoc.info/github/ruby-grape/grape/Grape/API Grape::API documentation
  class Api < Grape::API
    # @see GameToken::API
    mount GameToken::Api
  end
end
