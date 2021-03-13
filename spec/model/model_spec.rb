# frozen_string_literal: true

require 'spec_helper'

describe Model::Model do
  before(:all) do
    @test_identifier = :test_id_field
    @model = Model::Model.new(
      ds_identifier: @test_identifier
    )
  end

  context 'when the model has an ds_identifier attribute' do
    it 'defaults to the value of :id' do
      test_model = Model::Model.new

      expect(test_model.ds_identifier).to eql(:id)
    end

    it 'throws a Dry::Struct::Error if the value is invalid' do
      expect do
        Model::Model.new(
          ds_identifier: nil
        )
      end.to raise_error(Dry::Struct::Error)
    end

    it 'returns the current ds_identifier' do
      expect(@model.ds_identifier).to eql(@test_identifier)
    end
  end
end
