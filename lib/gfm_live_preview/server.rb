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

    def render_document(ws, relative_path)
      document = GfmLivePreview.read_file relative_path
      syntax_highlight! document
      doc = GitHub::Markdown.render_gfm document
      EM.next_tick { ws.send doc }
    end

    def setup_websockets(request, relative_path = nil)
      request.websocket do |ws|
        ws.onopen do
          render_document ws, relative_path
          listener = Listen.to GfmLivePreview.root do 
            render_document ws, relative_path
          end
          listener.start
          settings.sockets << ws
        end
        ws.onclose do
          settings.sockets.delete ws
        end
      end
    end

    get "/" do
      if request.websocket?
        setup_websockets request
      else
        erb :index
      end
    end

    # Support local assets like images
    get "/*" do
      path = params[:splat].first

      local_path = ::GfmLivePreview.root.join path

      halt 404 unless local_path.exist?

      mime_type = MIME::Types.type_for(local_path.basename.to_s).first

      if mime_type && mime_type.raw_media_type == "image"
        content_type mime_type.content_type
        File.read local_path
      elsif %w(.md .markdown).include? local_path.extname
        if request.websocket?
          setup_websockets request, path
        else
          erb :index
        end
      else
        halt 404
      end
    end
  end
end
