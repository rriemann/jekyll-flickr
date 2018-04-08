# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jekyll-flickr/version"

Gem::Specification.new do |spec|
  spec.name          = "jekyll-flickr"
  spec.version       = Jekyll::Onebox::VERSION
  spec.authors       = ["Robert Riemann"]
  spec.email         = ["robert@riemann.cc"]
  spec.summary       = "Liquid tag for responsive Flickr images using HTML5 srcset."
  spec.homepage      = "https://github.com/rriemann/jekyll-flickr"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 2.1"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r!^bin/!) { |f| File.basename(f) }
  # spec.test_files    = spec.files.grep(%r!^(test|spec|features)/!)
  spec.require_paths = ["lib"]

  spec.add_dependency "jekyll-cache", "~> 1.2"
  spec.add_dependency "flickraw-cached", ">= 20120701"
  spec.add_dependency "flickraw", "~> 0.9.9"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "jekyll", ">= 3.0"
  spec.add_development_dependency "rake"
end
