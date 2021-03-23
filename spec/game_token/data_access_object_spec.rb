# frozen_string_literal: true

require 'spec_helper'

describe GameToken::DataAccessObject do
  let(:test_model_array) { create_game_token_model_array }
  let(:test_hash_array) { create_game_token_full_hash_array }
  let(:data_source) { instance_double(Data::DataSource) }
  let(:data_context) { GameToken::DataAccessObject.new(data_source: data_source) }

  context 'when initializing a new GameToken::DataAccessObject object' do
    it 'should set the data_kind attribute value' do
      dao = GameToken::DataAccessObject.new(data_source: data_source)
      expect(dao.data_kind).to eql('GameToken')
    end
  end

  context 'when the insert method is called' do
    context 'with non-existent model array' do
      it 'inserts models and returns the entities inserted' do
        allow(data_context).to receive(:find_all_by_name)
        expect(data_source).to receive(:insert).with(test_model_array).and_return(test_hash_array)

        return_value = data_context.insert(test_model_array)

        expect(data_context).to respond_to(:insert)
        expect(return_value).to eql(test_hash_array)
      end
    end

    context 'with existing model array' do
      it 'raises App::CustomErrors::ItemAlreadyExistsError' do
        allow(data_context).to receive(:find_all_by_name).and_return(test_hash_array)

        expect do
          data_context.insert(test_model_array)
        end.to raise_error(App::CustomErrors::ItemAlreadyExistsError)
      end
    end
  end

  context 'when the update method is called' do
    context 'with non-existent model array' do
      it 'updates models and returns the entities updated' do
        expect(data_source).to receive(:update).with(test_hash_array).and_return(test_hash_array)

        return_value = data_context.update(test_model_array)

        expect(data_context).to respond_to(:update)
        expect(return_value).to eql(test_hash_array)
      end
    end

    context 'with existing model array' do
      it 'raises App::CustomErrors::ItemDoesNotExistError' do
        allow(data_source).to receive(:update).and_raise(App::CustomErrors::ItemDoesNotExistError)

        expect do
          data_context.update(test_model_array)
        end.to raise_error(App::CustomErrors::ItemDoesNotExistError)
      end
    end
  end

  context 'when the find_all_by_name method is called' do
    let(:query_mock) { double('query_mock') }

    it 'creates a query and runs it' do
      expect(data_source).to receive(:query).and_return(query_mock)
      expect(data_source).to receive(:run).with(query_mock).and_return(test_hash_array)
      expect(query_mock).to receive(:where).exactly(test_hash_array.count).times

      return_value = data_context.find_all_by_name(test_model_array)

      expect(data_context).to respond_to(:find_all_by_name)
      expect(return_value).to eql(test_hash_array)
    end
  end
end