When you create a new site and repo, it comes with a default site framework, based on rails (since it uses rails).

```text
+ images
    - .symlink
+ javascripts
    - .symlink
+ stylesheets
    - .symlink
+ templates
    - .symlink
    - _header.html.erb
    - layout.html.erb
+ utilities
    - config.yml
    - services.rb
    - tasks.rake
```

> For information on `.symlink` files, see [this section](/docs/writing_code/hooking_into_rails). The rest of the files and directories are introduced below.

Images
----------------

Any *static images* for your site go here. Remember, each site has its own [media library](/docs/building_content/media_library), so the files you put here should be files that don't need to be dynamic.

Typically, this includes images like the logos, icons, backgrounds, and so forth. However, if you want to make those items dynamic, there's no reason you couldn't grab them from the database.

When hooked into rails, these files will go to `app/assets/images/viewer/[site_slug]`.

Images are best accessed via taproot's [view helpers](/docs/api_reference/view_helpers).

Javascripts
----------------

This is where all your javascript files go, including any vendor files not otherwise available in taproot. [Learn more about javascripts in taproot](/docs/writing_code/javascripts).

Since this is rails, your javascript manifest file is called from your layout, which you can read about in the [templates](#templates) section.

When hooked into rails, these files will go to `app/assets/javascripts/viewer/[site_slug]`.

Stylesheets
----------------

This is where all your CSS files go, including any vendor files not otherwise available in taproot. [Learn more about stylesheets in taproot](/docs/writing_code/stylesheets).

Since this is rails, your CSS manifest file is called from your layout, which you can read about in the [templates](#templates) section.

When hooked into rails, these files will go to `app/assets/stylesheets/viewer/[site_slug]`.

Templates
----------------

The templates directory holds all of your view files for your pages. It comes with two files by default.

The `templates` directory is symlinked to `app/views/viewer/[site_slug]`.

### Header Partial

`_header.html.erb` is really just a placeholder for a header. In conjunction with the layout, it demonstrates how you would include a self-contained partial in another view file. It can be deleted as necessary.

### Layout

At this time, you are only given one layout for your site. So, it should be as open-ended as possible, but you may need to add variables if you need to change content within your layout on the fly.

The layout comes names `layout.html.erb`, but you can call it whatever you want. What is more important is how it is hooked into rails, which you can read about [here](/docs/writing_code/hooking_into_rails).

While the files within this directory are symlinked, the layout is specifically symlinked to `app/views/layouts/viewer/[site_slug]`.


Utilities
----------------

There are some floating files that are hooked into different locations throughout the taproot app. They are placed in a utilities directory by default just to make your repo a little easier to manage. You can rename the directory anything you'd like as long as the symlinks within the files do not change.

We have three default utility files.

### config.yml

The `config.yml` file is a site-specific, static settings file. While the plan is to eventually make site settings dynamic, at this time they are kept in the code.

This file is symlinked to `config/sites/[site_slug].yml`.

### services.rb

The `services.rb` file is a service object - it is a class dedicated to the unique logic to a site. [Learn more about the service object](/docs/writing_code/the_service_object).

This file is symlinked to `app/services/[site_slug]_viewer.rb`.

### tasks.rake

You may want some custom rake tasks for your site. These go in your `tasks.rake` file. They can help you run automated tasks that are unique to one site on your app. [Learn more about rake tasks](/docs/writing_code/rake_tasks).

This file is symlinked to `lib/tasks/viewer/[site_slug].rake`.

***

Read on in this chapter's sections to learn the abilities of each of these components and how they can work together to help you create an awesome site.

