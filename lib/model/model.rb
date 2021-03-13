# frozen_string_literal: true

require 'dry-struct'

# Namespace for model related modules and classes
# @author Adrian Blair
module Model
  # Class representing a model structure which inherits from {https://dry-rb.org/gems/dry-struct Dry::Struct}
  #
  # @attr_reader [Symbol] ds_identifier holds the symbol representing the id attribute
  # @see https://dry-rb.org/gems/dry-struct Dry::Struct
  class Model < Dry::Struct
    attribute :ds_identifier, App::Types::Coercible::Symbol.default(:id)

    transform_keys(&:to_sym)
  end
end
