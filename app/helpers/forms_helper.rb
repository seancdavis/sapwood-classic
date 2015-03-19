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
      :url => api_v1_forms_path(:key => form.key)
    ) do |f|
      f.simple_fields_for :field_data do |field_data|
        o = f.input(
          :redirect_url,
          :as => :hidden,
          :input_html => { :value => request.url }
        )
        form.fields.each do |field|
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
          builder_site_form_submission_path(
            current_site, current_form, current_form_submission
          ),
          :class => 'disabled'
        )
      end
    end
    o.html_safe
  end

  def current_form_actions
    s = current_site
    f = current_form
    [
      {
        :title => "#{current_form_submissions.size} Submissions",
        :path => builder_site_form_submissions_path(current_site, current_form),
        :class => 'view',
        :controllers => ['submissions']
      },
      {
        :title => 'Fields',
        :path => '#',
        # :controllers => ['fields', 'groups'],
        :class => 'form'
      },
      {
        :title => 'Settings',
        :path => builder_route([f], :edit),
        :class => 'edit'
      },
      # {
      #   :title => 'Developer Help',
      #   :path => builder_route([t], :show),
      #   :class => 'help'
      # }
    ]
  end

end
