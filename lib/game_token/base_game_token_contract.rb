# frozen_string_literal: true

require 'dry-validation'

# Namespace for game token related modules and classes
# @author Adrian Blair
module GameToken
  # A contract validating data in a new game token
  #
  # - registers a macro :no_blank_spaces_format where it will fail if spaces are found
  #    register_macro(:no_blank_spaces_format) do
  #       key.failure('cannot contain any blank spaces') if value.match(' ')
  #    end
  # - registers a macro :only_unique_array_values where it will fail if repeating values are found
  #     register_macro(:only_unique_array_values) do
  #       key.failure('domains must be unique') if value && value.length != value.uniq.length
  #     end
  # @see https://dry-rb.org/gems/dry-validation Dry::Validation
  class BaseGameTokenContract < Dry::Validation::Contract
    # registers a macro which causes a failure in validation if blank spaces are found
    # @return [Object] failure
    # @see https://rubydoc.info/gems/dry-validation/Dry/Validation/Failures#failure-instance_method failure-instance_method
    register_macro(:no_blank_spaces_format) do
      key.failure('cannot contain any blank spaces') if value.match(' ')
    end

    # registers a macro which causes a failure in validation if duplicated elements are found
    # @return [Object] failure
    # @see https://rubydoc.info/gems/dry-validation/Dry/Validation/Failures#failure-instance_method failure-instance_method
    register_macro(:only_unique_array_values) do
      key.failure('domains must be unique') if value && value.length != value.uniq.length
    end
  end
end
