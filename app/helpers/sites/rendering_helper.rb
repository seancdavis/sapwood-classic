module Sites
  module RenderingHelper

    def data_table(headers, &block)
      content_tag(:table) do
        a = content_tag(:thead) do
          b = ''; headers.each { |header| b += content_tag(:th, header.upcase) }
          b.html_safe
        end
        a += content_tag(:tbody) { capture(&block) }
      end
    end

  end
end
