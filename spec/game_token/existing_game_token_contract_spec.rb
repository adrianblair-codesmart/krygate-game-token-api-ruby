# frozen_string_literal: true

require 'spec_helper'

describe GameToken::ExistingGameTokenContract do
  before(:all) do
    @params = {
      id: "token's id",
      token_name: "token's name",
      token_key: 'abc123',
      token_domains: ['localhost']
    }

    @contract = GameToken::ExistingGameTokenContract.new
  end

  context 'when the call method is called with a valid parameters hash' do
    it 'validates game token parameters without errors' do
      contract_result = @contract.call(@params)

      expect(contract_result.values.count).to eq(4)
      expect(contract_result.errors.count).to eq(0)
      expect(contract_result.values.key?(:id)).to be true
      expect(contract_result.values.key?(:token_name)).to be true
      expect(contract_result.values.key?(:token_key)).to be true
      expect(contract_result.values.key?(:token_domains)).to be true
    end
  end

  context 'when the call method is called with an empty parameters hash' do
    it 'validates game token parameters with errors' do
      contract_result = @contract.call({})
      contract_errors_hash = contract_result.errors.to_h

      expect(contract_result.values.count).to eq(0)
      expect(contract_result.errors.count).to eq(3)
      expect(contract_errors_hash.key?(:id)).to be true
      expect(contract_errors_hash.key?(:token_name)).to be true
      expect(contract_errors_hash.key?(:token_key)).to be true
    end
  end
end
