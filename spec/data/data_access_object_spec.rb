# frozen_string_literal: true

require 'spec_helper'

describe Data::DataAccessObject do
  before(:each) do
    @test_kind = 'test_kind'
    @test_id = 'test_id'
    @test_return_entity = {}

    @mock = instance_double(Data::DataSource)
    @data_context = Data::DataAccessObject.new(data_kind: @test_kind, data_source: @mock)
  end

  context 'when initializing a new Data::DataAccessObject object' do
    it 'should raise an error when the data_kind is not found' do
      expect do
        @contract = Data::DataAccessObject.new
      end.to raise_error(ArgumentError)
    end

    it 'should set the data_kind attribute value' do
      test_kind = 'TestKind'
      dao = Data::DataAccessObject.new(data_kind: test_kind)
      expect(dao.data_kind).to eql(test_kind)
    end
  end

  context 'when the find method is called' do
    it 'calls find on the data_source and returns the entity with the matching id' do
      expect(@mock).to receive(:find).with(@test_kind, @test_id).and_return(@test_return_entity)

      return_value = @data_context.find(@test_id)

      expect(@data_context).to respond_to(:find)
      expect(return_value).to equal(@test_return_entity)
    end
  end

  context 'when the query method is called' do
    it 'calls query on the data_source and returns a query object' do
      expect(@mock).to receive(:query).with(@test_kind).and_return(@test_return_entity)

      return_value = @data_context.query

      expect(@data_context).to respond_to(:query)
      expect(return_value).to equal(@test_return_entity)
    end
  end
end
