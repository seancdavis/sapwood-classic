This lists the helpers available to you in when authoring templates for your sites. This list is not comprehensive of all the view helpers in taproot - just the ones we think you'd care about.

> **Please note: The helpers are being organized per [this issue](https://github.com/seancdavis/sapwood/issues/36). Once complete, this page will become a full-blown API reference.**
>
> In the meantime, here is a brief outline of the helper methods available to you. But, more importantly, if you have a question on how to get data, [ask](/support).

### `current_page`

The cached `Page` object of the site being viewed.

> *Note: The documentation around this object is being organized and will be available soon*.

### `current_site`

The cached `Site` object of the site being viewed.

> *Note: The documentation around this object is being organized and will be available soon*.

### `slug_title(slug)`

Makes a title from the given `slug` by removing underscores and capitalizing the first letter of every word.

### `viewer_collection(collection, partial)`

Renders one partial template per object in a collection of objects.

For example, if you have an articles method in your `viewer_service` that returns a collection of pages, and you have a partial - `templates/_article.html.erb` - marked up to display that article, then you could render the collection like so:

```erb
<%= viewer_collection(viewer_sevice.articles, 'article') %>
```

### `viewer_image(filename, options = {})`

Renders an image with a given `filename` from your project's `images` directory.

If your image is nested, then use a path relative to your `images` directory for `filename`.

#### Options

The options here are passed directly to the `image_tag` helper. [Learn more](http://apidock.com/rails/ActionView/Helpers/AssetTagHelper/image_tag).

#### Related Helpers

There are other helpers that don't stand on their own, but use `viewer_image` to help.

* `viewer_image_path(filename)`: Get the *path* to the image within your `images` directory
* `main_header_image`: Renders an image named `header.jpg` in your `images` directory.
* `viewer_logo_image`: Renders an image named `logo.png` in your `images` directory.

### `viewer_main_nav(options = {})`

An automatic renderer to place root level pages in the following format.

```html
<nav>
  <ul>
    <li>
      <a href="<%# path to page %>"><%# adjusted page title %></a>
    </li>
    <!-- ... -->
  </ul>
</nav>
```

The adjusted page title is actually not the page title. Often we want what is displayed in the menu to be shorter than the actual title. While this will be amended in the future, the current version uses the page's `slug` attribute, removes the underscores, and titleizes it.

#### Options

* `nav_class`: Adds a class to the `nav` element.
* `ul_class`: Adds a class to the `ul` element.

### `viewer_page_title(title, options = {})`

Renders the title of the page in the following format:

```html
<header>
  <h1>
    <span><%# page title %></span>
  </h1>
</header>
```

#### Options

* `header`: A hash of options passed to `content_tag(:header)`. [Learn more](http://apidock.com/rails/ActionView/Helpers/TagHelper/content_tag)

### `viewer_partial`

Renders a partial template (with a preceding underscore) within the current sites directory.

For example, if you have a header, you would place it in `templates/_header.html.erb`. You could then call the header in a template file like so:

```erb
<%= viewer_partial('header') %>
```

### `viewer_service`

Instantiates (or references) an instance of the service object for the `current_site`. It provides access to all instance methods within that class. [Learn more](/docs/writing_code/the_service_object).
