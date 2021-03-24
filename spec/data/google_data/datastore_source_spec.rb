# frozen_string_literal: true

require 'spec_helper'
require 'google/cloud/datastore'

describe Data::GoogleData::DatastoreSource do
  let(:test_model_array) { create_game_token_model_array }
  let(:test_hash_array) { create_game_token_full_hash_array }
  let(:game_token_full_hash) { build(:game_token_full_hash) }
  let(:game_token_base_hash) { build(:game_token_base_hash) }



  let(:kind_and_key_hash) { build(:kind_and_key_hash) }
  let(:kind_and_key_hash_array) { build(:kind_and_key_hash_array) }
  let(:google_key) { build(:google_key) }
  let(:google_key_array) { build(:google_key_array) }
  let(:entity_mock) { create_entity_mock(game_token_base_hash, game_token_full_hash) }
  let(:test_id) { game_token_full_hash[game_token_full_hash[:ds_identifier]] }
  let(:test_kind) { game_token_full_hash[:ds_kind] }
  let(:data_store_mock) { double(Google::Cloud::Datastore) }
  let(:logger_mock) { App::AppLogger.instance }

  let(:data_source_parser) do
    create_data_source_parser_mock(
      entity_mock: entity_mock,
      test_model_array: test_model_array,
      game_token_base_hash: game_token_base_hash,
      test_hash_array: test_hash_array,
      kind_and_key_hash: kind_and_key_hash,
      kind_and_key_hash_array: kind_and_key_hash_array,
      google_key: google_key,
      google_key_array: google_key_array
    )
  end

  let(:data_source) do
    Data::GoogleData::DatastoreSource.new(data_store: data_store_mock, data_source_parser: data_source_parser)
  end

  before(:each) do
    mock_logger
  end

  context 'when the data source is constructed' do
    it 'should store the data source as an instance variable' do
      expect(data_source).to respond_to(:data_store)
      expect(data_source.data_store).to be(data_store_mock)
    end
  end

  context 'when the find method is called' do
    context 'with a valid kind and id' do
      it 'returns the entity with the matching kind and id' do
        expect(data_store_mock).to receive(:find).with(test_kind, test_id).and_return(entity_mock)

        return_value = data_source.find(test_kind, test_id)

        expect(data_source).to respond_to(:find)
        expect(return_value).to equal(game_token_base_hash)
      end
    end
  end

  context 'when the query method is called' do
    let(:query_mock) { instance_double(Google::Datastore::Query) }

    context 'with a valid kind' do
      it 'returns a query object' do
        expect(data_store_mock).to receive(:query).with(test_kind).and_return(query_mock)

        return_value = data_source.query(test_kind)

        expect(data_source).to respond_to(:query)
        expect(return_value).to equal(query_mock)
      end
    end
  end

  context 'when the query_string method is called' do
    it 'returns a Google::Cloud::Datastore::GqlQuery' do
      return_value = data_source.query_string

      expect(data_source).to respond_to(:query_string)
      expect(return_value).to be_a(Google::Cloud::Datastore::GqlQuery)
    end
  end

  context 'when the run method is called' do
    let(:query_mock) { instance_double(Google::Datastore::Query) }

    context 'with a valid query' do
      it 'returns an array of entities' do
        expect(data_store_mock).to receive(:run).with(query_mock).and_return(test_model_array)

        return_value = data_source.run(query_mock)

        expect(data_source).to respond_to(:run)
        expect(return_value).to equal(test_hash_array)
      end
    end
  end

  context 'when the insert method is called' do
    context 'with a valid model array' do
      it 'inserts and returns an array of entities' do
        expect(data_store_mock).to receive(:insert).with(test_model_array).and_return(test_model_array)

        return_value = data_source.insert(test_hash_array)

        expect(data_source).to respond_to(:insert)
        expect(return_value).to equal(test_hash_array)
      end
    end
  end

  context 'when the update method is called' do
    context 'with a valid model array' do
      it 'updates and returns an array of entities' do
        expect(data_store_mock).to receive(:update).with(test_model_array).and_return(test_model_array)

        return_value = data_source.update(test_hash_array)

        expect(data_source).to respond_to(:update)
        expect(return_value).to equal(test_hash_array)
      end
    end

    context 'with a model array containing entities which do not exist' do
      it 'attempts to update and raises an error' do
        expect(data_store_mock).to receive(:update).with(test_model_array).and_raise(Google::Cloud::NotFoundError)

        expect do
          data_source.update(test_hash_array)
        end.to raise_error(App::CustomErrors::ItemDoesNotExistError)

        expect(data_source).to respond_to(:update)
        expect(logger_mock).to have_received(:warn)
      end
    end
  end

  context 'when the save method is called' do
    context 'with a valid model array' do
      it 'saves and returns an array of entities' do
        expect(data_store_mock).to receive(:save).with(test_model_array).and_return(test_model_array)

        return_value = data_source.save(test_hash_array)

        expect(data_source).to respond_to(:save)
        expect(return_value).to equal(test_hash_array)
      end
    end
  end

  context 'when the delete method is called' do
    context 'with a valid model array' do
      it 'deletes and returns true' do
        #TODO need it to receive the converted keys


        expect(data_store_mock).to receive(:delete).with(google_key_array).and_return(true)

        return_value = data_source.delete(kind_and_key_hash_array)

        expect(data_source).to respond_to(:delete)
        expect(return_value).to equal(true)
      end
    end
  end
end
