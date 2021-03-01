# frozen_string_literal: true

require './lib/app/app_container'
require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem
loader.push_dir('lib')
loader.setup

Root::Api.compile!
run Root::Api
