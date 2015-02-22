The `stylesheets` directory in your project should hold all of your stylesheets.

Setup
----------------

### Using Sass

Rails has adopted [Sass](http://sass-lang.com/) as its preferred CSS preprocessor. Sass can help keep your CSS nice and organized, but if you don't want to, you aren't forced to use it.

### The Manifest File

If you're going the Rails way and using Sass, then you should create a manifest file - `application.scss` - from which you import all your style partials (and any vendor files).

You can place vendor files and partials at any location within the stylesheets directory and they will be available to be imported into your project.

> If you have a vendor file you believe would be useful to be available to all Sapwood projects, add it to the Sapwood repo, create a pull request and explain why it's useful.

Loading Stylesheets
----------------

Rails comes with a helper to load stylesheets - `stylesheet_link_tag`. In fact, if you look at your generated layout, you see this in the `<head>` section:

```erb
<%= stylesheet_link_tag 'viewer/[site_slug]/application', :media => 'all' %>
```

By default this will load your manifest file, as long as it is named `application.(s)css` (the file extension doesn't need to be `scss`).

You can change the name or load other stylesheets as necessary.

Frameworks & Helpers
----------------

### Available Frameworks

Sapwood currently doesn't support popular CSS frameworks like [Bootstrap](http://getbootstrap.com/) or [Foundation](http://foundation.zurb.com/). If you must have these options, then we suggest one of two solutions:

* Include the necessary files manually in your project.
* Add the ability to add these files to Sapwood and create your pull request.

### Sass Helper Libraries

In addition, we've made the [Bourbon](https://github.com/thoughtbot/bourbon) and [Compass](https://github.com/compass/compass-rails) gems available for you to include in your project as needed.

Like frameworks, feel free to open a pull request if you'd like to add a Sass library to Sapwood.
