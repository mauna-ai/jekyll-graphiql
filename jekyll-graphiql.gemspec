# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll-graphiql/version'

Gem::Specification.new do |spec|
  spec.name          = "jekyll-graphiql"
  spec.version       = Jekyll::Graphiql::VERSION
  spec.authors       = ["Diwank Tomer | Mauna AI"]
  spec.email         = ["developers@mauna.ai"]

  spec.summary       = %q{jekyll plugin to generate html snippets for embedding graphiql playgrounds}
  spec.description   = %q{jekyll plugin to generate html snippets for embedding graphiql playgrounds}
  spec.homepage      = "https://github.com/mauna-ai/jekyll-graphiql"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'jekyll'
  spec.add_dependency 'yaml'
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
