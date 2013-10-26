require "bundler/gem_tasks"

Bundler.require
require "markdown_previewer"

task :test do
  MarkdownPreviewer.run! File.expand_path("../test/sample.md", __FILE__)
end

task default: :test
