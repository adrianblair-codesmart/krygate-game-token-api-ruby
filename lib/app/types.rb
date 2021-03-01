# frozen_string_literal: true

require 'dry-types'

# Namespace for app related modules and classes
# @author Adrian Blair
module App
  # Class providing types for definitions
  #
  # includes {https://dry-rb.org/gems/dry-types/1.2 Dry.Types()}
  # @see https://dry-rb.org/gems/dry-types/1.2/ Dry.Types
  module Types
    include Dry.Types()
  end
end
