# frozen_string_literal: true

require 'spec_helper'

describe App::CustomErrors::ItemAlreadyExistsError do
  context 'when the ItemAlreadyExistsError is constructed' do
    it 'create an ItemAlreadyExistsError object with a default message' do
      error = App::CustomErrors::ItemAlreadyExistsError.new
      expect(error.message).to be("That item already exists.")
    end
  end
end
