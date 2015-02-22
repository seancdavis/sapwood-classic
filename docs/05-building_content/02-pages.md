As mentioned in [the chapter introduction](/docs/building_content), the structure of a site is almost entirely built around *pages*. And that determines a good portion of the code you will write.

Introducing Page Templates
----------------

We make the fields within our pages dynamic by applying *templates* to them. This follows similar logic to WordPress' [post types](http://codex.wordpress.org/Post_Types).

Templates give you the ability to define a custom (dynamic) set of attributes on a page. They also have some built-in helpers to help you build out the structure of your site in a way that makes sense to your editors.

Each template has its own *view file* (in your code), as necessary. We talk more about this in [the rendering process section](/docs/writing_code/rendering_process).

Creating Page Templates
----------------

Any of the following scenarios present the need for a template:

* You want to create a page (or pages) with a unique set of fields. For example, an *Article* page type might have a *featured image*.
* You want a certain page type to only be allowed to be created under one of your root-level pages.

Try to keep it as simple as possible. Only create a template when you actually need one. And **pay attention to all of the developer settings for your template.** Check out the bottom of this doc for an example.

### Creating A New Template

Creating a new template happens in the templates section. Creating a new page, however, happens in the pages section, which is based strictly on the options you have added for your templates. In other words, you can only create pages of a certain template based on where you said that could happen.

Sapwood was built in this way because it helps your editors navigate the page portion of the builder in the site tree structure.

Template Fields
----------------

The *form fields* are the dynamic fields for each page created with that particular template. Some fields are protected because they are columns on the database, but you can still rename and reorder them.

WHen you create a dynamic field, it creates a *method on the `Page` object with the `name`* you give it. For example, if a page needs a sidebar, you would create a field called *Sidebar* with a name `sidebar`. Then, when you mark up your view file, you could get to that sidebar doing something like this:

```erb
<%= current_page.sidebar.html_safe %>
```

### Grouping Fields

Sometimes templates need a lot of custom fields. That gets messy for one form. Sapwood give you the ability to group fields. Each group essentially becomes its own *Settings* form on any page created with that template.

For example, let's say you have a *Location* template. It would probably need an address, along with lots of other data. You might consider creating an *Address* group so the address fields become their own form, making it easier to edit data for that page.

### File Fields

The `file` field type is unique to the rest of the fields. Other field types just create text-based attributes cached on the page object. But the `file` field actually creates an association to a `Document` object.

> This isn't a true [Active Record Association](http://guides.rubyonrails.org/association_basics.html), but it acts like one.

Therefore, if you have a `file` field on your page, then calling that field's `name` only gives you the document.

For example, let's say your template has an `image` field. If you were to call it like other fields on pages of the same template, you would do:

```erb
<%= current_page.image %>
```

In this case, that returns

```text
=> #<Document:0x007f044c765500>
```

To get to the [Dragonfly](http://markevans.github.io/dragonfly) image (file) object, you need to call `document` on that document, and then you have access to Dragonfly's methods (which is what Sapwood uses for managing files).

See [this section](http://markevans.github.io/dragonfly/models/#urls) in Dragonfly's docs for info on some of the methods available to you.

But, if you wanted the original image, then you'd need to do something like this:

```erb
<%= viewer_image(current_page.image.document.url) %>
```

Template Options
----------------

Templates have several built-in features that help you to build a specific content structure. See the options below. We'll use *News* and *Article* templates as examples throughout to demonstrate which options might be selected.

### Template Filename

This determines the *view file* you will create, **without the `.html.erb` extension.**

For example, if you have a *News* template, you would probably want this setting to be `news`, which would mean your view file would be `news.html.erb`.

### Can have root pages?

If this is selected, then when you are on the root listing of pages, you will see a button for a creating a page with that template (assuming other options do not override this).

For example, for a *News* template, you would likely want it to have root pages, while an *Article* **would not**, since you would want those pages to only be created under the news template.

### Child Templates

Child templates determine which page templates can be created *from* this page template.

For example, your *News* template would allow *Article* pages to be created as children, while an *Article* would probably not have any children.

### Order Method & Direction

You can set up the direction to order pages of this template. This won't be necessary all the time.

For example, this is irrelevant for *News*, as you likely only have one page created with the *News* template. But with the *Article* template, you might want its pages ordered by `publish_date` in `desc` order.

### Limiting Pages

Lastly, you can limit the number of pages created with this page template. This comes in handy when that number is predictable.

For example, you only need one page for *News*, so you would check the box to limit and put `1` in the *Max Pages* field. But for *Article* pages, there would be no limit, since you can have an unlimited number of articles (in most cases).

> The *Developer Help* page is available for every template and gives you a synopsis of the options set up for that template, semantically.

***

It can be a little confusing, so let's consider a couple examples.

Example: Home Page Slider
----------------

In this case, consider:

> We have a home page that has a dynamic feature slider that can have an unlimited number of features.

Since features should be dynamic, they should be their own template. So, we'd create a *Feature* template with these *extra* fields:

* `image` (the image to display in the slider)
* `button_text` (the label for a call-to-action button)
* `url` (the url or path for the call-to-action button)

For all the other fields, we can use the other fields we always have (title, body, description, etc.).

Now, even if the home page doesn't have any unique fields, what is unique to it is that it is the only page from which features can be created. So, we should create a *Home* template without any unique fields. But you would select *Feature* as a child template of *Home*.

Then, you create your home page from your home template form. And, from that you can create features.

See, not too difficult.

Another trick to consider here is that **not every page needs a view template**. You are forced to choose a template, but you might not use it. In the case of features, they probably don't have their own url, right? But they are still pages. *Just because you have a page doesn't mean the page has to have a url*.

Example: Site Structure
----------------

Let's look at a site overall, with some more typical components. Let's say our requirements are:

* home page with feature slider
* blog posts
* about page with subpages, including a team page that lists team members' photos and bios
* contact form

Here's just one approach for configuring the templates on this site:

```text
=> Home (limit pages, max: 1)
------> Feature (no limit)
=> About Root (limit pages, max: 1)
------> About (no limit)
------> Team (limit pages, max: 1)
------------> Team Member (no limit)
=> News (limit pages, max: 1)
------> Article (no limit)
=> Contact (limit pages, max: 1)
```

There are a few items to make note of if this scenario.

First, you see that all of our root-level templates have a max of 1 page. The advantage to this is that once the first page is created, there won't be any more allowed. This makes it easier on your editors, because then they won't be able to create any root-level pages. It also makes your navigation easier to build.

Also note the *About Root* can be difficult to name. I say it doesn't matter too much because after you create the first one, you don't have to mess with it again. It's better to save semantic naming the pages you will continue to create throughout the life of the site.

Also, note that you *could* use the *About* template in both cases, and say *About* is an child template of itself. This makes it infinitely nestable. But, there are a few negative effects to this. First, you will still be able to create root pages, and second you will be able to infinitely nest about pages, which could be confusing to your editors.
