module FormsHelper

  def site_forms
    @site_forms ||= current_site.forms.includes(:form_submissions)
  end

  def current_form
    @current_form ||= begin
      p = params[:form_slug] || params[:slug]
      current_site.forms.find_by_slug(p)
    end
  end

  def current_form_submissions
    @current_form_submissions ||= current_form.submissions.desc.page(params[:page]).per(10)
  end

  def current_form_submission
    @current_form_submission ||= begin
      current_form.submissions.find_by_idx(params[:idx])
    end
  end

  def current_form_fields
    @current_form_fields ||= current_form.fields.in_position
  end

  def current_form_field
    @current_form_field ||= begin
      slug = params[:form_field_slug] || params[:slug]
      current_form_fields.select { |f| f.slug == slug }.first
    end
  end

  def redirect_field(f)
    f.input(
      :redirect_route,
      :as => :hidden,
      :wrapper => false,
      :input_html => { :value => params[:redirect_route] || request.path }
    )
  end

  def form_field_options
    [
      ['String', 'string'],
      ['Textarea', 'text'],
      ['Dropdown', 'select'],
      ['Date', 'date'],
      ['Checkbox', 'boolean'],
      ['Checkboxes', 'check_boxes'],
      ['Radio Buttons', 'radio_buttons'],
      ['File', 'file']
    ].sort
  end

  def form_view(form)
    unless form.nil?
      if params[:form] && params[:form] == form.key
        if params[:result] && params[:result] == 'success'
          form.thank_you_body.html_safe
        elsif form
          o = content_tag(
            :p,
            'There was an error with your submission.',
            :class => 'error'
          )
          o += form_markup(form)
          o.html_safe
        else
          form_markup(form)
        end
      else
        form_markup(form)
      end
    end
  end

  def form_markup(form)
    simple_form_for(
      FormSubmission.new,
      :url => api_v1_forms_path(:key => form.key),
      :html => { :honeypot => true }
    ) do |f|
      f.simple_fields_for :field_data do |field_data|
        o = f.input(
          :redirect_url,
          :as => :hidden,
          :input_html => { :value => request.url }
        )
        form.fields.visible.in_position.each do |field|
          o += form_field_view(field, field_data)
        end
        o += content_tag(:div, :class => 'submit') do
          f.submit(form.button_label)
        end
        o.html_safe
      end
    end
  end

  def form_field_view(field, form)
    case field.data_type
    when 'select', 'check_boxes', 'radio_buttons'
      form.input(
        field.slug.to_sym,
        :as => field.data_type,
        :label => field.show_label ? field.label || field.title : false,
        :collection => field.option_values,
        :required => field.required,
        :selected => field.default_value
      )
    when 'boolean'
      form.input(
        field.slug.to_sym,
        :as => field.data_type,
        :label => field.show_label ? field.label || field.title : false,
        :collection => field.option_values,
        :required => field.required,
        :input_html => {
          :checked => field.default_value.to_bool
        }
      )
    when 'file'
      form.input(
        "rtfile_#{field.slug}".to_sym,
        :as => field.data_type,
        :label => field.show_label ? (field.label.blank? ? field.title :
          field.label) : false,
        :required => field.required
      )
    else
      form.input(
        field.slug.to_sym,
        :as => field.data_type,
        :label => field.show_label ? field.label || field.title : false,
        :required => field.required,
        :placeholder => field.placeholder,
        :input_html => {
          :value => field.default_value
        }
      )
    end
  end

  def builder_form_field_view(field, form, submission)
    case field.data_type
    when 'select', 'check_boxes', 'radio_buttons'
      form.input(
        field.slug.to_sym,
        :as => field.data_type,
        :collection => field.option_values,
        :required => field.required,
        :selected => submission.send(field.slug) || field.default_value
      )
    when 'boolean'
      form.input(
        field.slug.to_sym,
        :as => field.data_type,
        :collection => field.option_values,
        :required => field.required,
        :input_html => {
          :checked => submission.send(field.slug).to_bool
        }
      )
    else
      form.input(
        field.slug.to_sym,
        :as => field.data_type,
        :required => field.required,
        :input_html => {
          :value => submission.send(field.slug) || field.default_value
        }
      )
    end
  end

  def current_form_breadcrumbs
    o = link_to("all forms", builder_route([site_forms], :index))
    if current_form
      o += content_tag(:span, '/', :class => 'separator')
      if current_form.title.blank?
        o += link_to(
          "new form",
          builder_route([current_form], :new)
        )
      else
        o += link_to(
          current_form.slug,
          builder_route([current_form], :show)
        )
      end
      if current_form_submission
        o += content_tag(:span, '/', :class => 'separator')
        o += link_to(
          current_form_submission.title.downcase,
          builder_route([current_form, current_form_submission], :show),
          :class => 'disabled'
        )
      elsif current_form_field
        o += content_tag(:span, '/', :class => 'separator')
        if current_form_field.title.blank?
          o += link_to(
            "new field",
            builder_route([current_form, current_form_fields], :new),
            :class => 'disabled'
          )
        else
          o += link_to(
            current_form_field.slug,
            builder_route([current_form, current_form_field], :edit),
            :class => 'disabled'
          )
        end
      end
    end
    o.html_safe
  end

  def current_form_actions
    s = current_site
    f = current_form
    subs = current_form_submissions
    actions = [
      {
        :title => "#{current_form_submissions.size} Submissions",
        :path => builder_route([f, subs], :index),
        :class => 'view',
        :controllers => ['submissions']
      }
    ]
    if current_user.admin?
      actions << {
        :title => 'Fields',
        :path => builder_route([current_form, current_form_fields], :index),
        :controllers => ['fields'],
        :class => 'form'
      }
      actions << {
        :title => 'Settings',
        :path => builder_route([f], :edit),
        :class => 'edit'
      }
    end
    actions
  end

end
