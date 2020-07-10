# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'era_835_parser/version'

Gem::Specification.new do |spec|
  spec.name          = "era_835_parser"
  spec.version       = Era835Parser::VERSION
  spec.authors       = ["Kevin S. Dias"]
  spec.email         = ["diasks2@gmail.com"]
  spec.summary       = %q{Electronic Remittance Advice (ERA) 835 parser}
  spec.description   = %q{This is a gem to parse ERAs, the electronic equivalent of a paper Explanation of Benefits (EOB) used in the medical industry. An electronic remittance advice (ERA) is an electronic data interchange (EDI) version of a medical insurance payment explanation. It provides details about providers' claims payment, and if the claims are denied, it would then contain the required explanations.}
  spec.homepage      = "https://github.com/diasks2/era_835_parser"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec"
end