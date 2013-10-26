module GfmLivePreview
  class SyntaxHighlighter
    MATCHER = %r{^```(.+?)$(.*?)^```$}m

    def self.highlight! str
      str.gsub! MATCHER do |match|
        code_snippet = $2
        language = Linguist::Language.find_by_alias $1
        language.colorize code_snippet
      end
    end
  end
end
