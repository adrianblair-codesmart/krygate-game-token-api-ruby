# frozen_string_literal: true

require 'spec_helper'
require 'google/cloud/datastore'
require 'byebug'

describe Data::Google::DatastoreSource do
  before(:each) do
    @test_kind = 'test_kind'
    @test_id = 'test_id'
    @test_entity = {}
    @test_return_entity = {}
    @test_return_array = [{}]

    @test_params = {
      ds_identifier: 'token_id',
      ds_kind: 'GameToken',
      id: 'token_id',
      token_name: "token's name",
      token_key: 'abc123',
      token_domains: ['localhost']
    }

    @test_model = GameToken::Model.new(@test_params)

    @data_store_mock = double(Google::Cloud::Datastore)
    @data_source = Data::Google::DatastoreSource.new(data_store: @data_store_mock)
  end

  context 'when the data source is constructed' do
    it 'should store the data source as an instance variable' do
      expect(@data_source).to respond_to(:data_store)
      expect(@data_source.data_store).to be(@data_store_mock)
    end
  end

  context 'when the find method is called' do
    it 'calls find on the data_source and returns the entity with the matching id' do
      expect(@data_store_mock).to receive(:find).with(@test_kind, @test_id).and_return(@test_return_entity)

      return_value = @data_source.find(@test_kind, @test_id)

      expect(@data_source).to respond_to(:find)
      expect(return_value).to equal(@test_return_entity)
    end
  end

  context 'when the query method is called' do
    it 'calls query on the data_source and returns a query object' do
      expect(@data_store_mock).to receive(:query).with(@test_kind).and_return(@test_return_array)

      return_value = @data_source.query(@test_kind)

      expect(@data_source).to respond_to(:query)
      expect(return_value).to equal(@test_return_array)
    end
  end

  context 'when the insert method is called' do
    it 'calls insert on the data_source and returns an entity object' do
      expect(@data_store_mock).to receive(:insert).with(@test_return_array).and_return(@test_return_array)

      return_value = @data_source.insert(@test_return_array)

      expect(@data_source).to respond_to(:insert)
      expect(return_value).to equal(@test_return_array)
    end
  end

  context 'when the update method is called' do
    it 'calls update on the data_source and returns an entity object' do
      expect(@data_store_mock).to receive(:update).with(@test_return_array).and_return(@test_return_array)

      return_value = @data_source.update(@test_return_array)

      expect(@data_source).to respond_to(:update)
      expect(return_value).to equal(@test_return_array)
    end
  end

  context 'when the save method is called' do
    it 'calls save on the data_source and returns an entity object' do
      expect(@data_store_mock).to receive(:save).with(@test_return_array).and_return(@test_return_array)

      return_value = @data_source.save(@test_return_array)

      expect(@data_source).to respond_to(:save)
      expect(return_value).to equal(@test_return_array)
    end
  end

  context 'when the delete method is called' do
    it 'calls delete on the data_source and returns true' do
      expect(@data_store_mock).to receive(:delete).with(@test_return_array).and_return(true)

      return_value = @data_source.delete(@test_return_array)

      expect(@data_source).to respond_to(:delete)
      expect(return_value).to equal(true)
    end
  end

  context 'when hash_to_entity is called with a hash object' do

    it 'converts the hash to an entity' do
      entity_mock = instance_double(Google::Cloud::Datastore::Entity)

      expect(@data_store_mock).to receive(:entity)
      .with(@test_params[:ds_kind], @test_params[:ds_identifier])
      .and_yield(entity_mock)
      .and_return(entity_mock)

      expect(entity_mock).to receive(:[]=).with(:token_name, @test_params[:token_name])
      expect(entity_mock).to receive(:[]=).with(:token_key, @test_params[:token_key])
      expect(entity_mock).to receive(:[]=).with(:token_domains, @test_params[:token_domains])

      return_value = @data_source.hash_to_entity(@test_params)

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

      allow(@data_source).to receive(:hash_to_entity)
      @data_source.hashes_to_entities(test_hash_array)

      expect(@data_source).to have_received(:hash_to_entity).exactly(4).times.with(@test_params)
    end

    it 'calls return an array of objects' do
      test_hash_array = [
        @test_params,
        @test_params,
        @test_params,
        @test_params
      ]

      allow(test_hash_array).to receive(:map).and_return(@test_return_array)
      return_value = @data_source.hashes_to_entities(test_hash_array)

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
      allow(entity_key_mock).to receive(:name).and_return(@test_params[:ds_identifier])

      entity_properties_mock = double
      allow(entity_properties_mock).to receive(:to_h).and_return(entity_hash)

      allow(entity_mock).to receive(:properties).and_return(entity_properties_mock)
      allow(entity_mock).to receive(:key).and_return(entity_key_mock)

      return_value = @data_source.entity_to_hash(entity_mock)
      expect(return_value).to eq(@test_params)
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

      allow(@data_source).to receive(:entity_to_hash)
      @data_source.entities_to_hashes(test_entity_array)

      expect(@data_source).to have_received(:entity_to_hash).exactly(4).times.with(@test_entity)
    end

    it 'calls return an array of objects' do
      test_entity_array = [
        @test_entity,
        @test_entity,
        @test_entity,
        @test_entity
      ]

      allow(test_entity_array).to receive(:map).and_return(@test_return_array)
      return_value = @data_source.entities_to_hashes(test_entity_array)

      expect(test_entity_array).to have_received(:map)
      expect(return_value).to be(@test_return_array)
    end
  end
end