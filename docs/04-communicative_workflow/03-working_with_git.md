You collaborate on taproot code using [Git](http://git-scm.com/). If you're not familiar with it, you should become so. And not just for this project. It is an awesome program, and you should use it to track changes in all of your development projects, regardless of whether or not you work on a team.

> Check out a taproot author's [guide on getting started with git](http://thepolymathlab.com/learn-git-in-an-hour).

As mentioned in [creating a site from scratch](/docs/creating_a_site/starting_from_scratch), you need a remote repository. You really can use any service for this. Check out [this article](http://thepolymathlab.com/free-alternatives-to-github-for-private-git-hosting) if you're looking for free options.

That's as far as we'll go with any intro to Git. They rest is up to you.

Project Organization
----------------

All the projects are actually [Git submodules](http://git-scm.com/book/en/v2/Git-Tools-Submodules) within taproot's `projects` directory. This is because taproot itself is a Git repository.

Creating And Importing
----------------

It's important you following the [guide to creating and importing](/docs/creating_a_site), which essentially means you need to create or bring the project repo on to your machine via the app's interface (not on the command line).

Making Changes
----------------

We don't yet manage code changes through the app. We figured you can't write any code through the app, so it doesn't make sense yet. So, you should go through the standard git workflow on the command line (or via some [Git GUI](http://git-scm.com/download/gui/linux)).

Deploying Changes
----------------

There is, however, a way to deploy changes you've made without logging into the server. In site settings, there is an "Update Repo" option which will pull the code and go through a server reset. It *can* be run in development, but it's most useful in deploying the code to production.
