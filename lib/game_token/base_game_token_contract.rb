# frozen_string_literal: true

require 'dry-validation'

# Namespace for game token related modules and classes
# @author Adrian Blair
module GameToken
  # A contract validating data in a new game token
  #
  # @see https://dry-rb.org/gems/dry-validation Dry::Validation
  class BaseGameTokenContract < Dry::Validation::Contract
    register_macro(:no_blank_spaces_format) do
      key.failure('cannot contain any blank spaces') if value.match(' ')
    end

    register_macro(:only_unique_array_values) do
      key.failure('domains must be unique') if value && value.length != value.uniq.length
    end
  end
end
