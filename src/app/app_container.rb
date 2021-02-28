require 'dry/container'
require 'dry/auto_inject'

module App
  class AppContainer
    extend Dry::Container::Mixin

    register 'test_string' do
      'our nice string...'
    end
  end

  Import = Dry::AutoInject(AppContainer)
end
