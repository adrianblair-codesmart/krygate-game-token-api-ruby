# frozen_string_literal: true

require 'spec_helper'

describe Data::DataContext do
  before(:each) do
    @test_kind = 'test_kind'
    @test_id = 'test_id'
    @test_entity = {}
    @test_return_entity = {}

    @mock = instance_double(Data::DataSource)
    @data_context = Data::DataContext.new(data_source: @mock)
  end

  context 'the model has a data source read attribute' do
    it 'returns the current data source' do
      data_source = @data_context.data_source

      expect(@data_context).to respond_to(:data_source)
      expect(data_source).to equal(@mock)
    end
  end

  context 'when the find method is called' do
    it 'calls find on the data_source and returns the entity with the matching id' do
      expect(@mock).to receive(:find).with(@test_kind, @test_id).and_return(@test_return_entity)

      return_value = @data_context.find(@test_kind, @test_id)

      expect(@data_context).to respond_to(:find)
      expect(return_value).to equal(@test_return_entity)
    end
  end

  context 'when the query method is called' do
    it 'calls query on the data_source and returns a query object' do
      expect(@mock).to receive(:query).with(@test_kind).and_return(@test_return_entity)

      return_value = @data_context.query(@test_kind)

      expect(@data_context).to respond_to(:query)
      expect(return_value).to equal(@test_return_entity)
    end
  end

  context 'when the insert method is called' do
    it 'calls insert on the data_source and returns an entity object' do
      expect(@mock).to receive(:insert).with(@test_entity).and_return(@test_return_entity)

      return_value = @data_context.insert(@test_entity)

      expect(@data_context).to respond_to(:insert)
      expect(return_value).to equal(@test_return_entity)
    end
  end

  context 'when the update method is called' do
    it 'calls update on the data_source and returns an entity object' do
      expect(@mock).to receive(:update).with(@test_entity).and_return(@test_return_entity)

      return_value = @data_context.update(@test_entity)

      expect(@data_context).to respond_to(:update)
      expect(return_value).to equal(@test_return_entity)
    end
  end

  context 'when the save method is called' do
    it 'calls save on the data_source and returns an entity object' do
      expect(@mock).to receive(:save).with(@test_entity).and_return(@test_return_entity)

      return_value = @data_context.save(@test_entity)

      expect(@data_context).to respond_to(:save)
      expect(return_value).to equal(@test_return_entity)
    end
  end

  context 'when the delete method is called' do
    it 'calls delete on the data_source and returns true' do
      expect(@mock).to receive(:delete).with(@test_id).and_return(true)

      return_value = @data_context.delete(@test_id)

      expect(@data_context).to respond_to(:delete)
      expect(return_value).to equal(true)
    end
  end
end
