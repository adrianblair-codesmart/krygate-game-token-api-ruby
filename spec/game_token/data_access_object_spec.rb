# frozen_string_literal: true

require 'spec_helper'

describe GameToken::DataAccessObject do
  let(:data_source) { instance_double(Data::DataSource) }

  context 'when initializing a new GameToken::DataAccessObject object' do
    it 'should set the data_kind attribute value' do
      dao = GameToken::DataAccessObject.new(data_source: data_source)
      expect(dao.data_kind).to eql('GameToken')
    end
  end
end
