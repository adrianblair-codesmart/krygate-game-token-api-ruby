# frozen_string_literal: true

require 'spec_helper'

describe Data::DataContext do
  let(:test_model_array) { create_game_token_model_array }
  let(:test_hash_array) { create_game_token_full_hash_array }
  let(:game_token_full_hash) { build(:game_token_full_hash) }
  let(:game_token_base_hash) { build(:game_token_base_hash) }
  let(:entity_mock) { create_entity_mock(game_token_base_hash, game_token_full_hash) }
  let(:test_id) { game_token_full_hash[game_token_full_hash[:ds_identifier]] }
  let(:test_kind) { game_token_full_hash[:ds_kind] }
  let(:data_source) { instance_double(Data::DataSource) }
  let(:data_context) { Data::DataContext.new(data_source: data_source) }


  context 'the model has a data source read attribute' do
    it 'returns the current data source' do
      expect(data_context).to respond_to(:data_source)
      expect(data_context.data_source).to equal(data_source)
    end
  end

  context 'when the find method is called' do
    it 'calls find on the data_source and returns the entity with the matching id' do
      expect(data_source).to receive(:find).with(test_kind, test_id).and_return(game_token_base_hash)

      return_value = data_context.find(test_kind, test_id)

      expect(data_context).to respond_to(:find)
      expect(return_value).to equal(game_token_base_hash)
    end
  end

  context 'when the query method is called' do
    it 'calls query on the data_source and returns a query object' do
      expect(data_source).to receive(:query).with(test_kind).and_return(game_token_base_hash)

      return_value = data_context.query(test_kind)

      expect(data_context).to respond_to(:query)
      expect(return_value).to equal(game_token_base_hash)
    end
  end

  context 'when the run method is called' do
    it 'runs the query on the data_source and returns a query result object' do
      expect(data_source).to receive(:run).with(entity_mock).and_return(game_token_base_hash)

      return_value = data_context.run(entity_mock)

      expect(data_context).to respond_to(:run)
      expect(return_value).to equal(game_token_base_hash)
    end
  end

  context 'when the insert method is called' do
    it 'calls insert on the data_source and returns an entity object' do
      expect(data_source).to receive(:insert).with(test_hash_array).and_return(test_hash_array)

      return_value = data_context.insert(test_model_array)

      expect(data_context).to respond_to(:insert)
      expect(return_value).to eql(test_hash_array)
    end
  end

  context 'when the update method is called' do
    it 'calls update on the data_source and returns an entity object' do
      expect(data_source).to receive(:update).with(test_hash_array).and_return(test_hash_array)

      return_value = data_context.update(test_model_array)

      expect(data_context).to respond_to(:update)
      expect(return_value).to eql(test_hash_array)
    end
  end

  context 'when the save method is called' do
    it 'calls save on the data_source and returns an entity object' do
      expect(data_source).to receive(:save).with(test_hash_array).and_return(test_hash_array)

      return_value = data_context.save(test_model_array)

      expect(data_context).to respond_to(:save)
      expect(return_value).to eql(test_hash_array)
    end
  end

  context 'when the delete method is called' do
    it 'calls delete on the data_source and returns true' do
      expect(data_source).to receive(:delete).with(test_hash_array).and_return(true)

      return_value = data_context.delete(test_model_array)

      expect(data_context).to respond_to(:delete)
      expect(return_value).to eql(true)
    end
  end

  context 'when the convert_models_to_hashes method is called with an object supporting to_h' do
    it 'converts them into a hash and returns them in an array' do
      return_value = data_context.convert_models_to_hashes(test_hash_array)

      expect(data_context).to respond_to(:convert_models_to_hashes)
      expect(return_value).to be_a_kind_of(Array)
      expect(return_value).to be_eql(test_hash_array)
    end
  end

  context 'when the convert_models_to_hashes method is called with an object not supporting to_h' do
    it 'throws a TypeError' do
      expect { data_context.convert_models_to_hashes(test_id) }.to raise_error TypeError
    end
  end
end
