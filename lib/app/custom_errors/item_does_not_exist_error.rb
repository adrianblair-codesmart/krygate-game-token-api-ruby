# frozen_string_literal: true

# Namespace for app related modules and classes
# @author Adrian Blair
module App
  # Namespace for the apps custom errors
  # @author Adrian Blair
  module CustomErrors
    # Error class which can be thrown when an item does not exist
    #
    class ItemDoesNotExistError < StandardError
      def initialize(msg = 'That item does not exist.')
        super
      end
    end
  end
end
