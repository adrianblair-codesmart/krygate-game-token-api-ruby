# frozen_string_literal: true

require 'spec_helper'

describe App::CustomErrors::ItemDoesNotExistError do
  context 'when the ItemDoesNotExistError is constructed' do
    it 'create an ItemDoesNotExistError object with a default message' do
      error = App::CustomErrors::ItemDoesNotExistError.new
      expect(error.message).to be("That item does not exist.")
    end
  end
end
