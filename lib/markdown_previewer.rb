require "listen"
require "linguist"
require "github/markdown"
require "sinatra"
require "sinatra-websocket"

require "markdown_previewer/server"
require "markdown_previewer/syntax_highlighter"
require "markdown_previewer/version"

module MarkdownPreviewer
  extend self

  attr :file

  def run! markdown_file
    @file = markdown_file
    MarkdownPreviewer::Server.run!
  end
end
