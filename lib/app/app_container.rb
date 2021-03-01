# frozen_string_literal: true

require 'dry/container'
require 'dry/auto_inject'

# Namespace for app related modules and classes
# @author Adrian Blair
module App
  # Class functioning as an dependency injection container
  #
  # @see Dry::Container::Mixin
  class AppContainer
    extend Dry::Container::Mixin

    register 'test_string' do
      'our nice string...'
    end
  end

  # Sets up the the dry auto inject container
  # @see Dry::AutoInject
  # @see https://dry-rb.org/gems/dry-auto_inject
  Import = Dry::AutoInject(AppContainer)
end
