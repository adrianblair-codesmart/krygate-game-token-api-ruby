# frozen_string_literal: true

require 'spec_helper'
require 'byebug'

describe GameToken::Model do
  before(:all) do
    @model = GameToken::Model.new(
      id: "token's id",
      token_name: "token's name",
      token_key: "token's key",
      token_domains: ['localhost']
    )
  end

  context 'the model has an id attribute' do
    it 'returns the current id' do
      expect(@model.id).to eql("token's id")
    end
  end

  context 'the model has a token name attribute' do
    it 'returns the current token name' do
      expect(@model.token_name).to eql("token's name")
    end
  end

  context 'the model has a token key attribute' do
    it 'returns the current token key' do
      expect(@model.token_key).to eql("token's key")
    end
  end

  context 'the model has a token domains attribute' do
    it 'returns the current token domains' do
      expect(@model.token_domains).to include('localhost')
    end
  end
end
