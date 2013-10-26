require "listen"
require "linguist"
require "github/markdown"
require "sinatra"
require "sinatra-websocket"

require "gfm_live_preview/server"
require "gfm_live_preview/syntax_highlighter"
require "gfm_live_preview/version"

module GfmLivePreview
  extend self

  attr :file

  def run! markdown_file
    @file = markdown_file
    Server.run!
  end
end
