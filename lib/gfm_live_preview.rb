require "listen"
require "linguist"
require "github/markdown"
require "sinatra"
require "sinatra-websocket"

require "gfm_live_preview/syntax_highlighter"
require "gfm_live_preview/version"

module GfmLivePreview
  extend self

  attr :file

  autoload :CLI,    "gfm_live_preview/cli"
  autoload :Server, "gfm_live_preview/server"

  def run! argv
    @file, options = CLI.parse argv
    config.update options
    Server.run!
  end

  def config
    @config ||= {}
  end

  def read_file(relative_path = nil)
    path = relative_path ? root.join(relative_path) : file
    File.read path
  end

  def root
    Pathname(File.expand_path("..", file))
  end
end
