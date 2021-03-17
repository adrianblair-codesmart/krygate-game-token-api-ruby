# frozen_string_literal: true

require 'spec_helper'
require 'google/cloud/datastore'

describe Data::Google::DatastoreSource do
  let(:test_model_array) { create_game_token_model_array }
  let(:test_hash_array) { create_game_token_hash_array }
  let(:game_token_full_hash) { build(:game_token_full_hash) }
  let(:game_token_base_hash) { build(:game_token_base_hash) }
  let(:entity_mock) { create_entity_mock(game_token_base_hash, game_token_full_hash) }
  let(:test_id) { game_token_full_hash[game_token_full_hash[:ds_identifier]] }
  let(:test_kind) { game_token_full_hash[:ds_kind] }
  let(:data_store_mock) { double(Google::Cloud::Datastore) }

  let(:data_source_parser) do
    create_data_source_parser_mock(
      entity_mock: entity_mock,
      test_model_array: test_model_array,
      game_token_base_hash: game_token_base_hash,
      test_hash_array: test_hash_array)
  end

  let(:data_source) { Data::Google::DatastoreSource.new(data_store: data_store_mock, data_source_parser: data_source_parser) }

  context 'when the data source is constructed' do
    it 'should store the data source as an instance variable' do
      expect(data_source).to respond_to(:data_store)
      expect(data_source.data_store).to be(data_store_mock)
    end
  end

  context 'when the find method is called' do
    it 'calls find on the data_source and returns the entity with the matching id' do
      expect(data_store_mock).to receive(:find).with(test_kind, test_id).and_return(entity_mock)

      return_value = data_source.find(test_kind, test_id)

      expect(data_source).to respond_to(:find)
      expect(return_value).to equal(game_token_base_hash)
    end
  end

  context 'when the query method is called' do
    let(:query_mock) { instance_double(Google::Datastore::Query) }

    it 'calls query on the data_source and returns a query object' do
      expect(data_store_mock).to receive(:query).with(test_kind).and_return(query_mock)

      return_value = data_source.query(test_kind)

      expect(data_source).to respond_to(:query)
      expect(return_value).to equal(query_mock)
    end
  end

  context 'when the insert method is called' do
    it 'calls insert on the data_source and returns an entity object' do
      expect(data_store_mock).to receive(:insert).with(test_model_array).and_return(test_model_array)

      return_value = data_source.insert(test_hash_array)

      expect(data_source).to respond_to(:insert)
      expect(return_value).to equal(test_hash_array)
    end
  end

  context 'when the update method is called' do
    it 'calls update on the data_source and returns an entity object' do
      expect(data_store_mock).to receive(:update).with(test_model_array).and_return(test_model_array)

      return_value = data_source.update(test_hash_array)

      expect(data_source).to respond_to(:update)
      expect(return_value).to equal(test_hash_array)
    end
  end

  context 'when the save method is called' do
    it 'calls save on the data_source and returns an entity object' do
      expect(data_store_mock).to receive(:save).with(test_model_array).and_return(test_model_array)

      return_value = data_source.save(test_hash_array)

      expect(data_source).to respond_to(:save)
      expect(return_value).to equal(test_hash_array)
    end
  end

  context 'when the delete method is called' do
    it 'calls delete on the data_source and returns true' do
      expect(data_store_mock).to receive(:delete).with(test_model_array).and_return(true)

      return_value = data_source.delete(test_hash_array)

      expect(data_source).to respond_to(:delete)
      expect(return_value).to equal(true)
    end
  end
end
