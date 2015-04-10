class SapwoodMarkdown

  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, lexer: language)
    end
  end

  def self.to_html(md)
    clean_md = self.clean_markdown(md)
    renderer = HTMLwithPygments.new(
      :with_toc_data => true, :hard_wrap => false
    )
    md = Redcarpet::Markdown.new(
      renderer, {
        :autolink => true, :space_after_headers => true, :tables => true,
        :fenced_code_blocks => true, :strikethrough => true,
        :underline => true, :highlight => true
      }
    )
    md.render(clean_md)
  end

  def self.html_to_markdown(html)
    ReverseMarkdown.convert(html)
  end

  private

    def self.clean_markdown(md)
      return "" if md.nil?
      md.gsub(
        /(?:http:\/\/)?(?:www\.)?(?:youtu\.be)\/(?:watch\?v=)?(.+)/,
        '<iframe width="420" height="345" src="http://www.youtube.com/embed/\1" frameborder="0" allowfullscreen></iframe>'
      ).gsub(
        /[”“]/,
        '"'
      ).gsub(
        /\[file\:(.*)\]/,
        '<p class="file"><code>\1</code></p>'
      )
    end

end
