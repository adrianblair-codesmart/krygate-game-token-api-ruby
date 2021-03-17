# frozen_string_literal: true

require 'spec_helper'

describe GameToken::NewGameTokenContract do
  let(:contract) { GameToken::NewGameTokenContract.new }
  let(:game_token_base_hash) { build(:game_token_base_hash) }

  context 'when the call method is called with a valid parameters hash' do
    it 'validates game token parameters without errors' do
      contract_result = contract.call(game_token_base_hash)

      expect(contract_result.values.count).to eq(3)
      expect(contract_result.errors.count).to eq(0)
      expect(contract_result.values.key?(:id)).to be false
      expect(contract_result.values.key?(:token_name)).to be true
      expect(contract_result.values.key?(:token_key)).to be true
      expect(contract_result.values.key?(:token_domains)).to be true
    end
  end

  context 'when the call method is called with an empty parameters hash' do
    it 'validates game token parameters with errors' do
      contract_result = contract.call({})
      contract_errors_hash = contract_result.errors.to_h

      expect(contract_result.values.count).to eq(0)
      expect(contract_result.errors.count).to eq(2)
      expect(contract_errors_hash.key?(:token_name)).to be true
      expect(contract_errors_hash.key?(:token_key)).to be true
    end
  end
end
