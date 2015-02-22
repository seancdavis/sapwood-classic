Once you [have some content](/docs/building_content) you can start writing code for your site.

Directory Structure
----------------

We suggest you become familiar with building a rails app, as this will follow much of the same process. As you can see, the [directory structure](/docs/writing_code/directory_structure) of a site mimics portions of a rails app. It simply strips out the code that is shared among most of the apps you create (which is the whole point of sapwood).

See [this section](/docs/writing_code/directory_structure) for an in-depth discussion on the directory structure of a site.

How it Works
----------------

Sapwood is really just one rails app. Each site you build is an individual Git submodule within the `projects` directory that is hooked into the overall rails app via [*symlinks*](http://en.wikipedia.org/wiki/Symbolic_link).

See [this section](/docs/writing_code/hooking_into_rails) for more information on hooking into the rails app.

All About Those Slugs
----------------

A `slug` is created from the `title` of the site when you create a site. It strips out bad characters and replaces spaces with hyphens. It remains as originally created even if you change the title of the site.

It is this slug that drives the name of your code repository, while it also helps to segment, or namespace, the files when they are hooked into the rails app.

You can find the slug of your site by looking at the first url segment when editing a site. For, example, if you're editing the home page, the url might look something like:

> http://localhost:3000/my-first-site/pages/home/edit

That would mean the slug for your site is `my-first-site`.

Whenever we symlink directories, we use the actual slug, but when we refer to filenames, we replace the hyphens with underscores, to fit into rails format.

***

Moving On ...
----------------

Give each of the sections in this chapter a read, as they are all important to understanding how the code works behind the scenes.
