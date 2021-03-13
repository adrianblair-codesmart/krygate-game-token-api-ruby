# frozen_string_literal: true

require 'spec_helper'
require 'dry-struct'
require 'byebug'

describe GameToken::Model do
  before(:all) do
    @model = GameToken::Model.new(
      ds_kind: 'TestKind',
      id: "token's id",
      token_name: "token's name",
      token_key: "token's key",
      token_domains: ['localhost']
    )
  end

  context 'when the model has a ds_kind attribute' do
    it 'defaults to the value of "GameToken"' do
      test_model = GameToken::Model.new(
        id: "token's id",
        token_name: "token's name",
        token_key: "token's key",
        token_domains: ['localhost']
      )

      expect(test_model.ds_kind).to eql('GameToken')
    end

    it 'throws a Dry::Struct::Error if the value is invalid' do
      expect do
        GameToken::Model.new(
          ds_kind: nil,
          id: "token's id",
          token_name: "token's name",
          token_key: "token's key",
          token_domains: ['localhost']
        )
      end.to raise_error(Dry::Struct::Error)
    end

    it 'returns the current ds_kind' do
      expect(@model.ds_kind).to eql('TestKind')
    end
  end

  context 'when the model has an id attribute' do
    it 'defaults to the value of nil' do
      test_model = GameToken::Model.new(
        ds_kind: 'TestKind',
        token_name: "token's name",
        token_key: "token's key",
        token_domains: ['localhost']
      )

      expect(test_model.id).to be_nil
    end

    it 'returns the current id' do
      expect(@model.id).to eql("token's id")
    end
  end

  context 'when the model has a token name attribute' do
    it 'throws a Dry::Struct::Error if the value is invalid' do
      expect do
        GameToken::Model.new(
          ds_kind: 'TestKind',
          id: "token's id",
          token_name: nil,
          token_key: "token's key",
          token_domains: ['localhost']
        )
      end.to raise_error(Dry::Struct::Error)
    end

    it 'throws a Dry::Struct::Error if the value is  missing' do
      expect do
        GameToken::Model.new(
          ds_kind: 'TestKind',
          id: "token's id",
          token_key: "token's key",
          token_domains: ['localhost']
        )
      end.to raise_error(Dry::Struct::Error)
    end

    it 'returns the current token name' do
      expect(@model.token_name).to eql("token's name")
    end
  end

  context 'when the model has a token key attribute' do
    it 'throws a Dry::Struct::Error if the value is invalid' do
      expect do
        GameToken::Model.new(
          ds_kind: 'TestKind',
          id: "token's id",
          token_name: "token's name",
          token_key: nil,
          token_domains: ['localhost']
        )
      end.to raise_error(Dry::Struct::Error)
    end

    it 'throws a Dry::Struct::Error if the value is  missing' do
      expect do
        GameToken::Model.new(
          ds_kind: 'TestKind',
          id: "token's id",
          token_name: "token's name",
          token_domains: ['localhost']
        )
      end.to raise_error(Dry::Struct::Error)
    end

    it 'returns the current token key' do
      expect(@model.token_key).to eql("token's key")
    end
  end

  context 'when the model has a token domains attribute' do
    it 'throws a Dry::Struct::Error if the value is invalid' do
      expect do
        GameToken::Model.new(
          ds_kind: 'TestKind',
          id: "token's id",
          token_name: "token's name",
          token_key: "token's key",
          token_domains: nil
        )
      end.to raise_error(Dry::Struct::Error)
    end

    it 'throws a Dry::Struct::Error if the value is  missing' do
      expect do
        GameToken::Model.new(
          ds_kind: 'TestKind',
          id: "token's id",
          token_name: "token's name",
          token_key: "token's key"
        )
      end.to raise_error(Dry::Struct::Error)
    end

    it 'returns the current token domains' do
      expect(@model.token_domains).to include('localhost')
    end
  end
end
