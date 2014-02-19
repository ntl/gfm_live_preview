module GfmLivePreview
  class Server < ::Sinatra::Application
    enable :inline_templates
    set :bind, "0.0.0.0"
    set :port, GfmLivePreview.config.fetch(:port)
    set :sockets, []

    def syntax_highlight! str
      SyntaxHighlighter.highlight! str do |string, hexcolor|
        "<span style=\"color:##{hexcolor}\">#{string}</span>"
      end
    rescue => e
      puts "Exception during syntax highlighting: #{e}"
      e.backtrace.each do |line| puts line; end
    end

    def render_document
      document = File.read ::GfmLivePreview.file
      syntax_highlight! document
      GitHub::Markdown.render_gfm document
    end

    def doc_path
      File.expand_path '..', ::GfmLivePreview.file
    end

    get "/" do
      if request.websocket?
        request.websocket do |ws|
          ws.onopen do
            ws.send render_document
            listener = Listen.to doc_path do 
              ws.send render_document
            end
            listener.start
            settings.sockets << ws
          end
          ws.onclose do
            settings.sockets.delete ws
          end
        end
      else
        erb :index
      end
    end
  end
end
