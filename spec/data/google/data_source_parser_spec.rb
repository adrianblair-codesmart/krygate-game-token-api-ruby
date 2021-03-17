# frozen_string_literal: true

require 'spec_helper'
require 'google/cloud/datastore'

describe Data::Google::DataSourceParser do
  before(:each) do
    @test_entity = {}
    @test_return_array = [{}]

    @model = build(:game_token)
    @test_params = @model.to_h

    @expected_return_values = build(:game_token_base_hash)

    @data_store_mock = double(Google::Cloud::Datastore)
    @data_source_parser = Data::Google::DataSourceParser.new(data_store: @data_store_mock)
  end

  context 'when the data source parser is constructed' do
    it 'should store the data source as an instance variable' do
      expect(@data_source_parser).to respond_to(:data_store)
      expect(@data_source_parser.data_store).to be(@data_store_mock)
    end
  end

  context 'when hash_to_entity is called with a hash object' do
    it 'converts the hash to an entity' do
      entity_mock = instance_double(Google::Cloud::Datastore::Entity)

      expect(@data_store_mock).to receive(:entity)
        .with(@test_params[:ds_kind], @test_params[@test_params[:ds_identifier]])
        .and_yield(entity_mock)
        .and_return(entity_mock)

      expect(entity_mock).to receive(:[]=).with(:token_name, @test_params[:token_name])
      expect(entity_mock).to receive(:[]=).with(:token_key, @test_params[:token_key])
      expect(entity_mock).to receive(:[]=).with(:token_domains, @test_params[:token_domains])

      return_value = @data_source_parser.hash_to_entity(@test_params)

      expect(return_value).to be(entity_mock)
    end
  end

  context 'when hashes_to_entities is called with an array of hash objects' do
    it 'calls the hash_to_entity for each hash object' do
      test_hash_array = [
        @test_params,
        @test_params,
        @test_params,
        @test_params
      ]

      allow(@data_source_parser).to receive(:hash_to_entity)
      @data_source_parser.hashes_to_entities(test_hash_array)

      expect(@data_source_parser).to have_received(:hash_to_entity).exactly(4).times.with(@test_params)
    end

    it 'calls return an array of objects' do
      test_hash_array = [
        @test_params,
        @test_params,
        @test_params,
        @test_params
      ]

      allow(test_hash_array).to receive(:map).and_return(@test_return_array)
      return_value = @data_source_parser.hashes_to_entities(test_hash_array)

      expect(test_hash_array).to have_received(:map)
      expect(return_value).to be(@test_return_array)
    end
  end

  context 'when entity_to_hash is called with an entity object' do
    it 'converts the entity to a hash' do
      entity_mock = instance_double(Google::Cloud::Datastore::Entity)

      entity_hash = {
        token_name: "token's name",
        token_key: 'abc123',
        token_domains: ['localhost']
      }

      entity_key_mock = double
      allow(entity_key_mock).to receive(:kind).and_return(@test_params[:ds_kind])
      allow(entity_key_mock).to receive(:id).and_return(@test_params[@test_params[:ds_identifier]])

      entity_properties_mock = double
      allow(entity_properties_mock).to receive(:to_h).and_return(entity_hash)

      allow(entity_mock).to receive(:properties).and_return(entity_properties_mock)
      allow(entity_mock).to receive(:key).and_return(entity_key_mock)

      return_value = @data_source_parser.entity_to_hash(entity_mock)
      expect(return_value).to eq(@expected_return_values)
    end
  end

  context 'when entities_to_hashes is called with an array of entity objects' do
    it 'calls the entity_to_hash for each entity object' do
      test_entity_array = [
        @test_entity,
        @test_entity,
        @test_entity,
        @test_entity
      ]

      allow(@data_source_parser).to receive(:entity_to_hash)
      @data_source_parser.entities_to_hashes(test_entity_array)

      expect(@data_source_parser).to have_received(:entity_to_hash).exactly(4).times.with(@test_entity)
    end

    it 'calls return an array of objects' do
      test_entity_array = [
        @test_entity,
        @test_entity,
        @test_entity,
        @test_entity
      ]

      allow(test_entity_array).to receive(:map).and_return(@test_return_array)
      return_value = @data_source_parser.entities_to_hashes(test_entity_array)

      expect(test_entity_array).to have_received(:map)
      expect(return_value).to be(@test_return_array)
    end
  end
end
