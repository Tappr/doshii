# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'doshii/version'

Gem::Specification.new do |spec|
  spec.name          = "doshii"
  spec.version       = Doshii::VERSION
  spec.authors       = ["Romel Campos"]
  spec.email         = ["rcoolah@gmail.com"]

  spec.summary       = %q{Gem to wrap Doshii API}
  spec.description   = %q{Gem to wrap Doshii API}
  spec.homepage      = "https://github.com/devrc-trise/doshii"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "https://rubygems.org"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.7.0"
  spec.add_development_dependency "vcr", "~> 2.9.3"
  spec.add_development_dependency "webmock", "~> 1.21.0"

  spec.add_dependency "faraday", "~> 0.9.1"
  spec.add_dependency "faraday_middleware", "~> 0.10.0"
  spec.add_dependency "json", "~> 1.8.3"
end
