The first release of sapwood introduced us to a simplistic rendering process.As it grows, it will likely get more complicated, but this page will follow the variations in that process along the way.

The sapwood app operates in a few different namespaces. The *front-end* (or *public*) side of the app operates in the `viewer` namespace.

When a url is hit for the public site of a site within the sapwood app, it is directed to the `viewer/pages_controller#show` (it will hit the `home` action if it is the root url). [Here's the current version of that code](https://github.com/seancdavis/sapwood/blob/master/app/controllers/viewer/pages_controller.rb#L10-20).

The `show` action first tries to find the page by its slug. At this time, page slugs are unique to the site in which they exist, which is why we can query in this way. The action throws a `404` error if it finds no page.

If we have a page, then you can see we render the template at:

```text
"viewer/#{current_site.slug}/#{current_page_template}"
```

using the layout:

```text
"viewer/#{current_site.slug}"
```

It is for this reason that when [hooking into the app](/docs/writing_code/hooking_into_rails) you use the default settings - *because they are correct and tightly configured to that site*. If a symlink is named incorrectly, we're likely to end up with a `500` error because the app can't find the template or layout it is expecting. We want to throw this error instead of rescuing from it, so that you (as developer) know something is wrong and can fix it.
