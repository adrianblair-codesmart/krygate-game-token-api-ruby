# frozen_string_literal: true

require 'spec_helper'

describe Data::DataAccessObject do
  let(:data_source) { instance_double(Data::DataSource) }
  let(:data_context) { Data::DataAccessObject.new(data_kind: test_kind, data_source: data_source) }
  let(:game_token_full_hash) { build(:game_token_full_hash) }
  let(:game_token_base_hash) { build(:game_token_base_hash) }
  let(:test_id) { game_token_full_hash[game_token_full_hash[:ds_identifier]] }
  let(:test_kind) { game_token_full_hash[:ds_kind] }

  context 'when initializing a new Data::DataAccessObject object' do
    it 'should raise an error when the data_kind is not found' do
      expect do
        Data::DataAccessObject.new
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
      expect(data_source).to receive(:find).with(test_kind, test_id).and_return(game_token_base_hash)

      return_value = data_context.find(test_id)

      expect(data_context).to respond_to(:find)
      expect(return_value).to equal(game_token_base_hash)
    end
  end

  context 'when the query method is called' do
    let(:query_mock) { instance_double(Google::Datastore::Query) }

    it 'calls query on the data_source and returns a query object' do
      expect(data_source).to receive(:query).with(test_kind).and_return(query_mock)

      return_value = data_context.query

      expect(data_context).to respond_to(:query)
      expect(return_value).to equal(query_mock)
    end
  end
end
