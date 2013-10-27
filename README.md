# GfmLivePreview

Live preview your github flavored markdown file (with syntax highlighting!). Loads via sinatra on port 31337 of localhost.

## Installation

Add this line to your application's Gemfile:

    gem 'gfm_live_preview'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gfm_live_preview

## Usage

    GfmLivePreview.run! "/path/to/my/README.md"

Or, if you want to run it from the command line:

    $ gfm_live_preview "/path/to/my/README.md"

Now, sinatra should be serving up your README on port 31337.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
