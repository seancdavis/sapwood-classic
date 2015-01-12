The [Communicative Workflow](/docs/communicative_workflow) shows us that **content determines code**. And therefore, when you create a site, while the code base is created for you, you should build out some content before you start writing any code.

The Theory
----------------

The technical theory is that by creating one large and flexible data model vs. many, smaller and more content-specific models, you cut out a significant amount of *potential waste*.

Let's compare it to something like [WordPress](https://wordpress.org/). When you create a new WordPress site, it starts you with pages, posts and media. To use anything beyond these page types (WP calls them [post types](http://codex.wordpress.org/Post_Types)), you need a plugin.

> By the way, we don't dislike the WordPress structure, a lot of which exists today because their original goal was to spin up blog sites quickly. We're simply trying to solve a different problem.

We thought of the things every site has - *pages*. No, seriously, that's it.

Almost everything else is (or *could be*) an extension of a page.

We found that in creating sites using rails, that even when we tried to cut out waste, we were still doing different versions of the same thing over and over. They just had different names and a few different fields.

On top of that, we wanted to add some features for items that truly require different attention - forms and files.

If a site required anything beyond that, we'd consider it to be an *app* (vs. a *site*), and would need a completely different approach.

> Another btw: We're working on [a ruby gem](https://github.com/rocktree/cambium) to speed up *app* development.

It's a Little Weird
----------------

We understand it's an odd concept to get used to, but we think you'll like it. It cuts out a significant amount of waste in the development process and let's you focus on presentation, which means you end up with a better-looking site that acts essentially the same as it would have had you built a million different data models.

And, you're managing updates to the actual application that's driving the code in one, central place.

Read the subsections in this chapter to learn the nuances of the content structure of a site.
