# frozen_string_literal: true

require 'spec_helper'
require 'google/cloud/datastore'

describe Data::DataSourceParser do
  let(:data_store_mock) { double(Data::DataSource) }
  let(:data_source_parser) { Data::Google::DataSourceParser.new(data_store: data_store_mock) }
  let(:game_token_full_hash) { build(:game_token_full_hash) }
  let(:game_token_base_hash) { build(:game_token_base_hash) }
  let(:test_model_array) { create_game_token_model_array }
  let(:game_token_base_hash_array) { create_game_token_base_hash_array }
  let(:game_token_full_hash_array) { create_game_token_full_hash_array }
  let(:game_token) { build(:game_token) }

  context 'when the data source parser is constructed' do
    it 'should store the data source as an instance variable' do
      expect(data_source_parser).to respond_to(:data_store)
      expect(data_source_parser.data_store).to eql(data_store_mock)
    end
  end

  context 'when hash_to_entity is called with a hash object' do
    it 'should respond to the hash_to_entity call' do
      expect(data_source_parser).to respond_to(:hash_to_entity).with(1).argument
    end
  end

  context 'when entity_to_hash is called with an entity object' do
    it 'should respond to the entity_to_hash call' do
      expect(data_source_parser).to respond_to(:entity_to_hash).with(1).argument
    end
  end

  context 'when hashes_to_entities is called with an array of hash objects' do
    it 'calls the hash_to_entity for each hash object' do
      allow(data_source_parser).to receive(:hash_to_entity)
      data_source_parser.hashes_to_entities(game_token_full_hash_array)

      expect(data_source_parser).to have_received(:hash_to_entity).exactly(4).times.with(game_token_full_hash)
    end

    it 'calls return an array of objects' do
      allow(data_source_parser).to receive(:hash_to_entity).and_return(game_token)
      return_value = data_source_parser.hashes_to_entities(game_token_full_hash_array)

      expect(return_value).to eql(test_model_array)
    end
  end

  context 'when entities_to_hashes is called with an array of entity objects' do
    it 'calls the entity_to_hash for each entity object' do
      allow(data_source_parser).to receive(:entity_to_hash)
      data_source_parser.entities_to_hashes(test_model_array)

      expect(data_source_parser).to have_received(:entity_to_hash).exactly(4).times.with(game_token)
    end

    it 'calls return an array of objects' do
      allow(data_source_parser).to receive(:entity_to_hash).and_return(game_token_base_hash)
      return_value = data_source_parser.entities_to_hashes(test_model_array)

      expect(return_value).to eql(game_token_base_hash_array)
    end
  end
end
