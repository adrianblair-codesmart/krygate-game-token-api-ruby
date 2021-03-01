# frozen_string_literal: true

require 'dry/container'
require 'dry/auto_inject'

# Namespace for app related modules and classes
# @author Adrian Blair
module App
  # Class functioning as an dependency injection container
  #
  # @see https://dry-rb.org/gems/dry-auto_inject Dry::Container::Mixin
  class AppContainer
    extend Dry::Container::Mixin

    register 'data_source' do
      return Data::Google::DatastoreSource.new
    end
  end

  # Sets up the the dry auto inject container
  # @see https://dry-rb.org/gems/dry-auto_inject Dry::AutoInject
  Import = Dry::AutoInject(AppContainer)
end
