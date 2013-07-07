lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "altria/connected_instrument_test/version"

Gem::Specification.new do |spec|
  spec.name          = "altria-connected_instrument_test"
  spec.version       = Altria::ConnectedInstrumentTest::VERSION
  spec.authors       = ["Rejasupotaro"]
  spec.email         = ["rejasupotaro@gmail.com"]
  spec.summary       = "Altria connected instrument test plugin"
  spec.homepage      = "https://github.com/takiguchi0817/connected_instrument_test"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "altria"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
