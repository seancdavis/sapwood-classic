Forms are like page types, except the *pages* are responses from your site's visitors. After working with templates, you'll pick up how to build a form real quickly.

> *NOTICE: Forms have not been given priority, as pages and templates are what really drive most sites. Forms will be given some love on a later minor version in v1.*
>
> *NOTICE: Also note that these docs provide the base you need, but are lacking in describing all the features. This is in preparation for forms becoming more flexible. The attributes of a form are annotated in the builder, so please make note of the text on screen when creating a form.*

Creating Forms
----------------

Whenever you are in a form view, there is a *New Form* button from which you can create new, custom forms.

### Custom Fields

Currently, the fields are defined within the forms using the form tabs. This will be changes to work more like pages and templates, once those two areas are more refined.

Today, you add one field and a time and then save the form.

Rendering a Form
----------------

You need to hard-code a form into a specific page template, but you can do so using some Sapwood helpers.

First, you have to find the form, which is done best via the form's slug. You get the slug from the URL when inside the form builder (it should look like `.../forms/[form_slug]/edit`). To retrieve the form object, you can use the following code from within your service object.

[file:utilities/service.rb]

```ruby
def contact_form
  @site.forms.find_by_slug(slug) # where `slug` is the form slug
end
```

If you have retrieved the form object, then in your view, all you need is:

```erb
<%= form_markup(viewer_service.contact_form) %>
```

And the form will be automatically rendered.

Form Submissions
----------------

Form submissions are the default view for a form in the builder. They offer a view of each submission. Aside from that, not much can be done with this data through the UI today. Enhancements will be coming later in v1.
