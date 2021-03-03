# frozen_string_literal: true

require 'spec_helper'
require 'byebug'

class ContainerObject
  include Dry::Container::Mixin
end

describe App::AppContainer do
  context 'test' do
    it 'should allow me to do this' do
      app_container = App::AppContainer.instance
    end
  end
end

# we need it to respond to :[], register, resolve
# test that registering and resolving works
