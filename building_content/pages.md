As mentioned in [the chapter introduction](/docs/building_content), the structure of a site is almost entirely built around *pages*. And that determines a good portion of the code you will write.

We make the fields within our pages dynamic by grouping them into *page types*. This follows similar logic to WordPress' [post types](http://codex.wordpress.org/Post_Types).

When to Create a Page Type
----------------

You want to create a page type when **you have a unique set of fields you need to capture dynamically.** Try to keep it simple. If the difference between two pages should be the markup, then you want a different *template* (read about those below). If what differs is actual *types* of content, then you need a specific page type.

For example, let's say you have a news section that has a sidebar with content. If you want each article to define that content, then you probably want a *page type*. If you are going to predetermine what that content is, then all you need is a template.

Templates
----------------

A page's *template* determines the markup that is rendered when the page is loaded. Technically, it determines which *view file* to load (we talk more about this in [the rendering process section](/docs/writing_code/rendering_process)).

Available templates are defined at the page type level.

Templates can be shared across page types, although that doesn't make a ton of sense, since the reason you're creating a page type in the first place is to define a different set of fields.

Root-Level Pages
----------------

Root-level pages are those pages that appear in the CMS sidebar. They are the gateway to the rest of the pages in your site.

Sometimes these pages are each their own page type. For example, a *home page* is likely a different page type than a *news listing*, while a *contact page* might just be a different template of your standard page template.

Root-level pages are generated from the page type itself. That way we know which fields to render in the form when you go to create and edit the page.

> **Note: You can not change the page type for a particular page after it has been created.**

Child Pages
----------------

Pages are infinitely-nestable. However, the way we ensure page types are predictable is by defining a set of *available children* for each page type.

For example, if you have a *News Listing* page type, the only pages you want to be created under it are (probably) *Articles*. Within the page type form, you can define the page types that can be created under the page type. After you define this set of available children, links will appear in each of that page type's pages' forms.

An Example
----------------

It's a little confusing. Let's consider an example. Here's the scenario:

> We have a home page that has a dynamic feature slider.

If you want the features to be dynamic, they should be their own page type, because they likely have unique. So, we'd create a *Feature* page type with these *extra* fields:

* `image` (the image to display in the slider)
* `button_text` (the label for a call-to-action button)
* `url` (the url or path for the call-to-action button)

For all the other fields, we can use the other fields we always have (title, body, description, etc.).

Now, even if the home page doesn't have any unique fields, what is unique to it is that it is the only page from which features can be created. So, we should create a *Home* page type without any unique fields. But you would select *Feature* as an available child of *Home*.

Then, you create your home page from your home page type form. And, from that you can create features.

See, not too difficult.

> It might seem weird that we would consider a *feature* to be a page type. But, when you think about it, it uses the same simple fields - title, description, and has some additional fields on top of it.

Another trick to consider here is that **not every page needs a view template**. You are forced to choose a template, but you might not use it. In the case of features, they probably don't have their own url, right? But they are still pages. Just because you have a page *doesn't mean the page has to have a url*.
