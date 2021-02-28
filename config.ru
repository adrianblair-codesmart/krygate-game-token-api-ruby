require './src/app/app_container'
require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem
loader.push_dir('src')
loader.setup

Root::Api.compile!
run Root::Api
