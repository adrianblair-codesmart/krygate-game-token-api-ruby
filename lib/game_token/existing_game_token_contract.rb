# frozen_string_literal: true

require 'dry-validation'

# Namespace for game token related modules and classes
# @author Adrian Blair
module GameToken
  # A contract validating data in a new game token
  #
  # @attr_reader [String] id holds the id of the game token
  # @attr_reader [String] token_name holds the name of the game token
  # @attr_reader [String] token_key holds the key of the game token
  # @attr_reader [Array<String>] token_domains an array of domains of which the game token validates against
  # @see https://dry-rb.org/gems/dry-validation Dry::Validation
  class ExistingGameTokenContract < GameToken::BaseGameTokenContract
    params do
      # TODO: ID should have no spaces.
      required(:id).filled(:string)
      required(:token_name).filled(:string)
      # TODO: shouldn't be changeable through a post
      # TODO: should have no spaces
      required(:token_key).filled(:string)
      # TODO: should have no spaces
      # TODO: should be a set so that the values are unique.
      optional(:token_domains).array(:string)
    end

    rule(:token_key).validate(:no_blank_spaces_format)
    rule(:token_domains).validate(:only_unique_array_values)
    rule(:token_domains).each do
      key.failure('cannot contain any blank spaces') if value.match(' ')
    end
  end
end
