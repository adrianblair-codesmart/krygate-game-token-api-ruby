# frozen_string_literal: true

require 'dry-validation'

# Namespace for game token related modules and classes
# @author Adrian Blair
module GameToken
  # A contract validating data in a new game token
  #
  # - required [String] token_name holds the name of the game token
  # - required [String] token_key holds the key of the game token
  # - optional [Array<String>] token_domains an array of domains of which the game token validates against
  # @see https://dry-rb.org/gems/dry-validation Dry::Validation
  class NewGameTokenContract < GameToken::BaseGameTokenContract
    params do
      required(:token_name).filled(:string)
      required(:token_key).filled(:string)
      optional(:token_domains).array(:string)
    end

    rule(:token_key).validate(:no_blank_spaces_format)
    rule(:token_domains).validate(:only_unique_array_values)

    # This validation is very simple and only to help prevent user error.
    # In reality if this was a public facing API then the validation would have to be
    # alot more stringent.
    # An example would be to use something like @see https://github.com/johno/domain-regex domain-regex.
    rule(:token_domains).each do
      key.failure('cannot contain any blank spaces') if value.match(' ')
    end
  end
end
