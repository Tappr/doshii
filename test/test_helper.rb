$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'doshii'
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

require './test/doshii/base_test'

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
end
