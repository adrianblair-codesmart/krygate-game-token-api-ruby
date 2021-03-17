# frozen_string_literal: true

require 'logger'
require 'singleton'

# Namespace for app related modules and classes
# @author Adrian Blair
module App
  # Singleton Class functioning as a the app's logger
  #
  # includes {https://docs.ruby-lang.org/en/3.0.0/Singleton.html Singleton}
  # @see https://docs.ruby-lang.org/en/3.0.0/Singleton.html Singleton
  class AppLogger < Logger
    include Singleton

    def initialize
      super('game_token_api.log', 'daily')
    end
  end
end