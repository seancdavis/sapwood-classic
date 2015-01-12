The service object (in `utilities/sevices.rb` in your site repo) is where all of your server side logic should be placed. It's where you create customized queries, keeping your view templates nice and clean.

If you don't know about rails' service objects, they are pretty fantastic. If you want to know more, [peruse this article](http://brewhouse.io/blog/2014/04/30/gourmet-service-objects.html).

How it Works
----------------

The service object is a ruby class named after your site. So, if your site is called *My Site*" then taproot would have auto-generated the slug `my-site` for it, and your service object would be called `MySiteViewer`.

By default it looks like this:

```ruby
class MySiteViewer

  def initialize(site)
    @site = site
  end

end
```

We use an *instance* of this class to call its methods. Therefore, all methods will be written and *instance methods* and **not** *class methods*. That makes it possible for you to cache results into variables. You can see how to do this [below](#accessing-the-methods).

Writing Queries
----------------

You'd write queries in a similar way to how you'd write them in rails, but we need to alter them a bit. For instance, everything we do, we do within the context of a site (`@site`), which is set when the class is instantiated.

### Pages & Page Types

Pages are almost always going to be accessed through a page type. Because, if you recall from [our theory on content](/docs/building_content), page types take the place of otherwise static models. And because your queries are typically done by targeting specific models in an app, it makes sense that we'd usually start with a page type when attempting to get to a page, or a collection of pages.

For example, let's saying we have a page displaying a listing of news articles, where the articles have a page type of *Article*.

You wouldn't need to query the listing page at all, because taproot does that for you. What you need to query are the posts to display on that page. So, the first thing we need to do is give that method a name (let's say `articles`) and then query the page type.

Page types, like pages (and most other records in taproot) have a `slug` attribute that is unique to some other model it belongs to.

```ruby
def articles
  @site.page_types.find_by_slug('article')
end
```

Since we know we only have one page type within this site with a slug of `article`, and in know how the rails [`find_by_...` method](http://guides.rubyonrails.org/active_record_querying.html#find-by) works, we know what we have returned is a `PageType` object.

We then need to go one step further so we can actually get to the pages from that page type.

```ruby
def articles
  @site.page_types.find_by_slug('article').pages
end
```

And now we have all pages created with the page type *Article*.

Read on below for other query helpers.

### Forms

Forms are accessed similarly, except you only have one level to dig. Want you need is the slug of the form, which you can find on the forms edit form in your site builder.

So, if your form has a slug of `contact-us`, then you can grab that form like so:

```ruby
def contact_form
  @site.forms.find_by_slug('contact-us')
end
```

Ordering Results
----------------

Because our data types are dynamic, we don't create a physical database column for each data type - that would be ridiculous. But, we do cache one attribute of your choosing to order pages of a particular page type. This is accomplished on the page type's form.

These are stored as a `string` type, so it may not be a super fast query, but it will work.

> Remember, we're trying to solve for the problem of creating simple, unique sites quickly without duplicating effort. So, complex queries are not a forte of taproot (yet).

There are two scope helpers for ordering pages, and all they do is specify the direction by which to order the results.

Using the example above, let's say our articles are to be ordered by a custom `publish_date` field. We would want them in descending order, so we can adjust our query.

```ruby
def articles
  @site.page_types.find_by_slug('article').pages.desc
end
```

The opposite of the `desc` scope is `asc`.

> If you want to get more complex than that, you'll need to grab the pages and then sort your array of results. You should become familiar with Ruby's [`sort_by` method](http://apidock.com/ruby/Enumerable/sort_by).

Caching Results
----------------

As we mentioned above (and explain [below](#accessing-the-methods)), an instance of the service object is stored in a variable by taproot. That means that you can cache query results here, too, so that you don't have to hit the database a second time if you are running the same query twice on one page.

We do this by setting an instance variable and initializing it the first time the method is run.

Using our articles example, we could do this:

```ruby
def articles
  @articles ||= @site.page_types.find_by_slug('article').pages.desc
end
```

These queries can get quite long, and sometimes you need multiple lines to get a result. You can use `begin` to accomplish this.

```ruby
def articles
  @articles ||= begin
    @site.page_types.find_by_slug('article').pages.desc
  end
end
```

If you use the multi-line approach, make sure the last line in your block returns what you want the method to return.

### Using Views

Alternatively, you could use a template to store and instance variable that calls the service method. Just make sure you know it's the first time that method is called during the rendering process.

Pagination
----------------

taproot uses [Kaminari](https://github.com/amatsuda/kaminari) for pagination. You should read Kaminari's docs to learn more about how you can paginate results.

In general, though, it's quite simple. If you wanted 10 articles per page on your list page (keeping the example going), you would have something like this:

```ruby
def articles(page = 1)
  @articles ||= begin
    @site.page_types.find_by_slug('article').pages.desc.page(page).per(10)
  end
end
```

Since we're not in a model, it's safer here to pass a page to the method rather than trying to access the `params` from inside the service object.

### Rendering

If you're using pagination, don't forget to [generate the page links](https://github.com/amatsuda/kaminari#views).

### Arrays

Kaminari also lets you paginate arrays, in the case you needed more complex logic in your query.

Let's say you don't want to render articles that aren't published. That might look something like this.

```ruby
def articles(page = 1)
  @articles ||= begin
    articles = @site.page_types.find_by_slug('article').pages.desc
    articles = articles.select { |a| a.published == true }
    Kaminari.paginate_array(articles).page(page).per(10)
  end
end
```

Note here that you want to paginate after you have your results, otherwise you may lose records and not render the desired number of results.

Accessing the Methods
----------------

An instance of the service object is stored in the [`viewer_service` method](https://github.com/rocktree/taproot/blob/master/app/helpers/viewer_helper.rb#L3-5) which instantiates a `@viewer_service` variable.

And, because we already have the current site stored, everything happens nice and quick without hitting the database a million times.

The methods are therefore best accessed through the `viewer_service` method. So, in your template, you could call `viewer_service.articles` to access our example method.

Easy enough? Good! Go have fun.
