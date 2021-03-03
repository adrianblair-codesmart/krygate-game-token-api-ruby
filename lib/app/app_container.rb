# frozen_string_literal: true

require 'singleton'
require 'dry/container'
require 'dry/auto_inject'

# Namespace for app related modules and classes
# @author Adrian Blair
module App
  # Singleton Class functioning as a dependency injection container
  #
  # includes {https://docs.ruby-lang.org/en/3.0.0/Singleton.html Singleton}
  # includes {https://dry-rb.org/gems/dry-auto_inject Dry::Container::Mixin}
  # @see https://docs.ruby-lang.org/en/3.0.0/Singleton.html Singleton
  # @see https://dry-rb.org/gems/dry-auto_inject Dry::Container::Mixin
  class AppContainer
    include Singleton
    include Dry::Container::Mixin

    instance.register :data_source do
      Data::Google::DatastoreSource.new
    end
  end

  # Sets up the the dry auto inject container
  # @see https://dry-rb.org/gems/dry-auto_inject Dry::AutoInject
  Import = Dry::AutoInject(AppContainer.instance)
end
