# frozen_string_literal: true

# Namespace for app related modules and classes
# @author Adrian Blair
module App
  # Namespace for the apps custom errors
  # @author Adrian Blair
  module CustomErrors
    # Error class which can be thrown when an item already exists
    #
    class ItemAlreadyExistsError < StandardError
      def initialize(msg="That item already exists")
        super
      end
    end
  end
end
