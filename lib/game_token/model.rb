# frozen_string_literal: true

# Namespace for game token related modules and classes
# @author Adrian Blair
module GameToken
  # Class representing a game token model structure
  #
  # @attr [String] id holds the id of the game token
  # @attr [String] token_name holds the name of the game token
  # @attr [String] token_key holds the key of the game token
  # @attr [Array<String>] token_domains an array of domains of which the
  # game token validates against
  class Model
    attr_accessor :id, :token_name, :token_key, :token_domains
  end
end
