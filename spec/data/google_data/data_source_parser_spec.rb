# frozen_string_literal: true

require 'spec_helper'
require 'google/cloud/datastore'

describe Data::GoogleData::DataSourceParser do
  let(:data_store_mock) { double(Google::Cloud::Datastore) }
  let(:data_source_parser) { Data::GoogleData::DataSourceParser.new(data_store: data_store_mock) }
  let(:entity_mock) { create_entity_mock(game_token_base_hash, game_token_full_hash) }
  let(:game_token_full_hash) { build(:game_token_full_hash) }
  let(:game_token_base_hash) { build(:game_token_base_hash) }
  let(:test_model_array) { create_game_token_model_array }
  let(:game_token_base_hash_array) { create_game_token_base_hash_array }
  let(:game_token_full_hash_array) { create_game_token_full_hash_array }


  context 'when the data source parser is constructed' do
    it 'should store the data source as an instance variable' do
      expect(data_source_parser).to respond_to(:data_store)
      expect(data_source_parser.data_store).to be(data_store_mock)
    end
  end

  context 'when entity_to_hash is called with an entity object' do
    it 'converts the entity to a hash' do
      return_value = data_source_parser.entity_to_hash(entity_mock)
      expect(return_value).to eq(game_token_base_hash)
    end
  end

  context 'when hash_to_entity is called with a hash object' do
    it 'converts the hash to an entity' do
      expect(data_store_mock).to receive(:entity)
        .with(game_token_full_hash[:ds_kind], game_token_full_hash[game_token_full_hash[:ds_identifier]])
        .and_yield(entity_mock)
        .and_return(entity_mock)

      expect(entity_mock).to receive(:[]=).with(:token_name, game_token_full_hash[:token_name])
      # expect(entity_mock).to receive(:[]=).with(:token_key, game_token_full_hash[:token_key])
      expect(entity_mock).to receive(:[]=).with(:token_domains, game_token_full_hash[:token_domains])

      return_value = data_source_parser.hash_to_entity(game_token_full_hash)

      expect(return_value).to be(entity_mock)
    end
  end

  context 'when hashes_to_entities is called with an array of hash objects' do
    it 'calls the hash_to_entity for each hash object' do
      allow(data_source_parser).to receive(:hash_to_entity)
      data_source_parser.hashes_to_entities(game_token_full_hash_array)

      expect(data_source_parser).to have_received(:hash_to_entity).exactly(4).with(game_token_full_hash)
    end

    it 'calls return an array of objects' do
      allow(game_token_full_hash_array).to receive(:map).and_return(test_model_array)
      return_value = data_source_parser.hashes_to_entities(game_token_full_hash_array)

      expect(game_token_full_hash_array).to have_received(:map)
      expect(return_value).to be(test_model_array)
    end
  end

  context 'when entities_to_hashes is called with an array of entity objects' do
    it 'calls the entity_to_hash for each entity object' do

      allow(data_source_parser).to receive(:entity_to_hash)
      data_source_parser.entities_to_hashes(test_model_array)

      expect(data_source_parser).to have_received(:entity_to_hash).exactly(4).times
    end

    it 'calls return an array of objects' do
      allow(data_source_parser).to receive(:entity_to_hash).and_return(game_token_base_hash)
      return_value = data_source_parser.entities_to_hashes(test_model_array)

      expect(return_value).to eql(game_token_base_hash_array)
    end
  end
end
