The `javascripts` directory is (you guessed it!) for storing all your javascript files.

Setup
----------------

Following a similar pattern with stylesheets, you should include a manifest file at `javascripts/application.js`.

As you can see at the bottom of your default layout (`templates/layout.html.erb`), it expects a javascript file as mentioned above.

```erb
<%= javascript_include_tag 'viewer/[site_slug]/application' %>
```

You can [read more here](http://guides.rubyonrails.org/asset_pipeline.html#manifest-files-and-directives) if you are unfamiliar with loading files into the asset pipeline.

Frameworks
----------------

There are about a million javascript frameworks out there. We are partial to [Backbone.js](http://backbonejs.org/) and use [this gem](https://github.com/meleyal/backbone-on-rails) to bring it into rails.

To use Backbone, all you need to add to `application.js` are these two lines:

```js
//= require underscore
//= require backbone
```

We'll leave it up to you to set up your Backbone directory structure, but you can mimic [the builder's structure](https://github.com/seancdavis/sapwood/tree/master/app/assets/javascripts/builder) if you'd like.

Like CSS frameworks, we're not opposed to any others, but just haven't made them a priority because that's not what we use on a regular basis. Feel free to add others to sapwood and create a pull request explaining why they are beneficial.

> If you create a pull request to add a js framework, we're likely going to ask you to document how to use the library with sapwood.

Other Helpers
----------------

You can keep an eye on [our Gemfile](https://github.com/seancdavis/sapwood/blob/master/Gemfile) to know what other helpers are already in the repo.

And, again, feel free to add your own to sapwood if you think users will find global benefit to it.
