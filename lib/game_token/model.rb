# frozen_string_literal: true

require 'dry-struct'

# Namespace for game token related modules and classes
# @author Adrian Blair
module GameToken
  # Class representing a game token model structure which inherits from {https://dry-rb.org/gems/dry-struct Dry::Struct}
  #
  # @attr_reader [String] ds_kind holds the kind of the game token
  # @attr_reader [String] id holds the id of the game token
  # @attr_reader [String] token_name holds the name of the game token
  # @attr_reader [String] token_key holds the key of the game token
  # @attr_reader [Array<String>] token_domains an array of domains of which the game token validates against
  # @see https://dry-rb.org/gems/dry-struct Dry::Struct
  class Model < Model::Model
    attribute :ds_kind, App::Types::Strict::String.default('GameToken')
    attribute :id, App::Types::Coercible::String.optional.default(nil)
    attribute :token_name, App::Types::Strict::String
    #attribute :token_key, App::Types::Strict::String
    attribute :token_domains, App::Types::Array.of(App::Types::Strict::String)
  end
end
