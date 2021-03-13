# frozen_string_literal: true

require 'spec_helper'

describe GameToken::DataAccessObject do
  before(:each) do
    @test_kind = 'test_kind'
    @test_id = 'test_id'
    @test_return_entity = {}

    @mock = instance_double(Data::DataSource)
  end

  context 'when initializing a new GameToken::DataAccessObject object' do
    it 'should set the data_kind attribute value' do
      dao = GameToken::DataAccessObject.new(data_source: @mock)
      expect(dao.data_kind).to eql('GameToken')
    end
  end
end
