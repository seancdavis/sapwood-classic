It's nice to be able to preview your site as your developing, and we've made the process fairly straightforward.

At this point, you need to know your site's slug. When you're working in the builder, you've probably noticed the URL is something like this:

> http://localhost:3000/sites/my-first-site/pages/home/edit

To get to the preview, all you have to do is replace the `sites` prefix with `preview`, and then everything after your slug. The example above becomes:

> http://localhost:3000/preview/my-first-site

And that is the home page preview for your site.

This works in both development and production.

Using the URL
----------------

Of course, you can also just use the URL setting for your site to go directly to the site. In production, this assumes *that URL's A-record is pointing to the IP address of your production server*.

In development, you can add an entry for that URL `/etc/hosts` file to point to `127.0.0.1`.

> **WARNING! If you edit your hosts file in development, make sure you change it before you go live, AND don't forget you'll need the `:3000` after the domain name so you can target the port as well.**
