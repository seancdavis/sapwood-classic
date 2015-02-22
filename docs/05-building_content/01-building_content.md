The [Communicative Workflow](/docs/communicative_workflow) shows us that **content determines code**. When you create a site, the default code base is created for you. However, Sapwood works best if you determine your *content structure* before writing any code.

The Theory
----------------

The technical theory is that by creating one large and flexible data model vs. many, smaller and more content-specific models, you cut out a significant amount of *potential waste*.

Let's compare Sapwood to [WordPress](https://wordpress.org/) in this regard. When you create a new WordPress site, it starts you with pages, posts and media. To use anything beyond these [post types](http://codex.wordpress.org/Post_Types), you need a plugin.

> By the way, I don't dislike the WordPress structure. It is built to be able to spin up sites in a snap. Sapwood simply has a different purpose, which is to make building customized and flexible site easy.

So, what does every website have? *Pages*. No, seriously, that's it.

Most other components are (or *could be*) extensions of a page. I found in creating sites using rails that even when I tried to cut out waste, I was still building different versions of the same thing repeatedly. These things (models) just had different names and a different fields.

On top of that, there tended to be models that functioned different from pages, but existed in most of the sites I built - forms and files.

If a site required anything beyond that, it's usually because it was an *app* (vs. a *site*), and needed a completely different approach.

> I am developing [a ruby gem](https://github.com/rocktree/cambium) to speed up *app* development for projects that aren't *eligible* for Sapwood.

It's a Little Weird
----------------

I understand it's an odd concept to get used to, but I think you'll like it. It cuts out a significant amount of waste in the development process and let's you focus on presentation, which means you end up with a better-looking site that acts essentially the same as it would have had you built a million different data models. But it also let's you get on the command line and work in your favorite editor -- it still *feels* like developing.

***

The subsections in this chapter teach the nuances of the content structure of a site.
