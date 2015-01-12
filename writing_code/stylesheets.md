The `stylesheets` directory in your project should hold all of your stylesheets.

Setup
----------------

### Using Sass

Rails has adopted [Sass](http://sass-lang.com/) as its preferred CSS preprocessor. We love Sass, too!

We recommend you use Sass, but if you don't want to, you aren't forced to use it.

### The Manifest File

If you're going the Rails way and using Sass, then you should create a manifest file - `application.scss` - from which you import all your style partials (and any vendor files).

You can place vendor files and partials at any location within the stylesheets directory and they will be available to be imported into your project.

> If you have a vendor file you believe would be useful to be available to all taproot projects, add it to the taproot repo, create a pull request and explain why it's useful.

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

Revisiting the purpose of taproot, we're not attempting to create one-click websites. We want each and every site to be unique. Of course, you'll still share styles, and that's okay.

That is the reason why we haven't added options to include [Bootstrap](http://getbootstrap.com/) or [Foundation](http://foundation.zurb.com/) in your projects. We're not against it, it's just not a priority

If you must have these options, then we suggest one of two solutions:

* Include the necessary files manually in your project.
* Add the ability to add these files to taproot and create your pull request.

We've created [Bones](https://github.com/rocktree/bones) with a similar philosophy, and that is available to be added to your project.

To add it, add these two lines to **the top of** your `application.scss` file:

```scss
@import 'bourbon';
@import 'viewer/[site_slug]/bones/bones';
```

Then, copy the directory from `app/assets/stylesheets/builder/bones` to `stylesheets/bones` within your project's directory.

Last, in the `stylesheets/bones/bones.scss` file, replace all instances of `builder/` with `viewer/[site_slug]/` where `[site_slug]` is the slug for your site.

> Note #1: There is a plan for a major rewrite (v2.0) of Bones coming in Summer/Fall 2015. It looks to change the way in which it manages config files to make it easier to setup your project.
>
> Note #2: This process is not easy and a lot of it has to do with the way in which Bones loads its config (per note #1). When v2.0 of Bones is available, this process will be much simpler.

### Sass Helper Libraries

In addition, we've made the [Bourbon](https://github.com/thoughtbot/bourbon) and [Compass](https://github.com/compass/compass-rails) gems available for you to include in your project as needed.

Like frameworks, feel free to open a pull request if you'd like to add a sass library to taproot.
