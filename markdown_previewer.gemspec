# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'markdown_previewer/version'

Gem::Specification.new do |spec|
  spec.name          = "markdown_previewer"
  spec.version       = MarkdownPreviewer::VERSION
  spec.authors       = ["ntl"]
  spec.email         = ["nathanladd+github@gmail.com"]
  spec.description   = %q{Live preview your github flavored markdown file (with syntax highlighting!).}
  spec.summary       = %q{Live preview your github flavored markdown file (with syntax highlighting!). Loads via sinatra on port 31337 of localhost.}
  spec.homepage      = "https://github.com/ntl/markdown_previewer"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "github-linguist"
  spec.add_dependency "github-markdown"
  spec.add_dependency "listen"
  spec.add_dependency "sinatra"
  spec.add_dependency "sinatra-websocket"
end
