module Builder
  module RenderingHelper

    def page_title(title, &block)
      content_tag(:section, :class => 'page-title') do
        o = content_tag(:h1, title)
        o += capture(&block) if block_given?
        o.html_safe
      end
    end

    def data_table(collection, partial = nil)
      content_tag(:section, :class => 'data-table') do
        if partial.nil?
          render(collection)
        else
          render(:partial => partial, :collection => collection)
        end
      end
    end

    def form_tabs(tabs)
      content_tag(:ul, :class => 'tabs') do
        o = ''
        tabs.each do |t| 
          label = t.upcase.gsub(/\-/, ' ')
          o += content_tag(:li, link_to(label, '#', :data => { 
            :section => t.downcase } ))
        end
        o.html_safe
      end
    end

    def page_status(page)
      if page.published?
        content_tag(:a, 'Published', :class => 'published disabled')
      else
        content_tag(:a, 'Draft', :class => 'draft disabled')
      end
    end

  end
end
