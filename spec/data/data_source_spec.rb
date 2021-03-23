# frozen_string_literal: true

require 'spec_helper'

describe Data::DataSource do
  let(:data_source) { Data::DataSource.new }

  context 'when the find method is called' do
    it 'responds to the call' do
      expect(data_source).to respond_to(:find)
    end
  end

  context 'when the query method is called' do
    it 'responds to the call' do
      expect(data_source).to respond_to(:query)
    end
  end

  context 'when the query_string method is called' do
    it 'responds to the call' do
      expect(data_source).to respond_to(:query_string)
    end
  end

  context 'when the run method is called' do
    it 'responds to the call' do
      expect(data_source).to respond_to(:run)
    end
  end

  context 'when the insert method is called' do
    it 'responds to the call' do
      expect(data_source).to respond_to(:insert)
    end
  end

  context 'when the update method is called' do
    it 'responds to the call' do
      expect(data_source).to respond_to(:update)
    end
  end

  context 'when the save method is called' do
    it 'responds to the call' do
      expect(data_source).to respond_to(:save)
    end
  end

  context 'when the delete method is called' do
    it 'responds to the call' do
      expect(data_source).to respond_to(:delete)
    end
  end
end
