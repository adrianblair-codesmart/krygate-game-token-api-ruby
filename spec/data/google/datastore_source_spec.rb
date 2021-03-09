# frozen_string_literal: true

require 'spec_helper'
require 'google/cloud/datastore'

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
end
