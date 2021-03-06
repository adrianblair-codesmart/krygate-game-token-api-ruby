# frozen_string_literal: true

require 'spec_helper'
require './lib/game_token/data_access_object'

describe App::AppContainer do
  let(:app_container) { App::AppContainer.instance }

  context 'when the instance method is called' do
    it 'should return the app container singleton instance' do
      expect(App::AppContainer.instance).to be_a(App::AppContainer)
    end
  end

  context 'when the register method is called' do
    it 'should register a dependency into the container' do
      test_object = 'test_dependency'

      app_container.register(:test_dependency, test_object)

      app_container.key?(:test_dependency)
    end
  end

  context 'when the resolve method is called' do
    it 'should resolve a dependency from the container' do
      test_object = 'test_dependency'
      expect(app_container.resolve(:test_dependency)).to equal(test_object)
    end
  end

  context 'the container contains a data source' do
    it 'should resolve a dependency from the container' do
      expect(app_container.resolve(:data_source)).to be_kind_of(Data::DataSource)
    end
  end

  context 'the container contains a data source parser' do
    it 'should resolve a dependency from the container' do
      expect(app_container.resolve(:data_source_parser)).to be_kind_of(Data::DataSourceParser)
    end
  end

  context 'the container contains a game token dao' do
    it 'should resolve a dependency from the container' do
      expect(app_container.resolve(:game_token_dao)).to be_kind_of(GameToken::DataAccessObject)
    end
  end
end
