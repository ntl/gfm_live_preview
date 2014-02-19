require 'optparse'

module GfmLivePreview
  class CLI
    DEFAULTS = {
      port: 31337,
    }

    attr :argv

    def initialize(argv)
      @argv = argv
    end

    def self.parse(argv)
      new(argv).parse
    end

    def parse
      options = DEFAULTS.dup

      OptionParser.new do |opts|
        opts.banner = "Usage: #{File.basename($PROGRAM_NAME)} [options] FILE"

        opts.on '-p', '--port PORT', 'Specify port other than 31337' do |port|
          options[:port] = port.to_i
        end
      end.parse(argv)

      [argv.last, options]
    end
  end
end
