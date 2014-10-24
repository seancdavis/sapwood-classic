module Sites
  module RenderingHelper

    def page_title(title, &block)
      content_tag(:section, :class => 'page-title') do
        o = content_tag(:h1, title)
        o += capture(&block) if block_given?
        o.html_safe
      end
    end

    def data_table(headers, &block)
      content_tag(:table) do
        a = content_tag(:thead) do
          b = ''; headers.each { |header| b += content_tag(:th, header.upcase) }
          b.html_safe
        end
        a += content_tag(:tbody) { capture(&block) }
      end
    end

    def form_tabs(tabs)
      content_tag(:ul, :class => 'tabs') do
        o = ''
        tabs.each { |t| o += content_tag(:li, link_to(t.upcase, '#', :data => { 
          :section => t.downcase } )) }
        o.html_safe
      end
    end

  end
end
