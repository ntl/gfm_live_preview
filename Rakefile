require "bundler/gem_tasks"

Bundler.require
require "gfm_live_preview"

task :test do
  GfmLivePreview.run! File.expand_path("../test/sample.md", __FILE__)
end

task default: :test
