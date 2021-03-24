# frozen_string_literal: true

require 'spec_helper'

describe Model::Model do
  let(:model) { build(:base_model) }

  context 'when the model has an ds_identifier attribute' do
    it 'defaults to the value of :id' do
      expect(model.ds_identifier).to eql(:id)
    end

    it 'throws a Dry::Struct::Error if the value is invalid' do
      expect do
        Model::Model.new(
          ds_identifier: nil
        )
      end.to raise_error(Dry::Struct::Error)
    end
  end
end
