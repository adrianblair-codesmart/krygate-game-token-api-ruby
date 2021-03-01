# frozen_string_literal: true

require 'grape'

module Root
  class Api < Grape::API
    mount GameToken::Api
  end
end
