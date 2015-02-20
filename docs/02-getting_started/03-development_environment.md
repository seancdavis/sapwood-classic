Sapwood works best when you follow the [communicative workflow](/docs/communicative_workflow). This means we have one production server that manages and hosts the content, along with one or more development environments using that content in their own instance.

It makes more sense to first have a production instance running. If you haven't installed your production server yet, [refer to that section](/docs/getting_started/production_environment). If you are just installing a development instance to play around with Sapwood, it will work completely fine in that capacity.

Let's look at how to get a development environment setup.

Requirements
----------------

Any computer will work fine, as long as you can run ruby projects. For the sake of making this article brief, we're going to assume **you know how to run a Ruby on Rails application on your machine.** This also means that Windows is not the ideal operating system.

You don't need a ton of power or space to run this application, especially since your assets should be served remotely. This is what you will need:

* Ruby 2.1
* Git
* MySQL
* ImageMagick
* Qt

If you have all the packages required to use the programs listed above, then you should be good to go.

Clone Repo
----------------

You likely have a directory in which you store your web projects. If you don't, it really doesn't matter where you decide to put the project. Most people create a directory within their home directory, called whatever they prefer -- `sites`, `www`, `code`, `apps`, etc. It's your choice. Go into that directory and then clone the repository from GitHub.

```text
$ cd /path/to/your/codes
$ git clone git@github.com:seancdavis/sapwood.git -b release
```

> Note: Notice here we are specifically cloning the `release` branch of the sapwood repo. This branch tracks the most recent release, down to the patch.

Configure Application
----------------

We have a few things to configure before we can be up and running. First, your
database.

### Database

> **NOTICE: The communicative workflow is built around sharing your product database.** The [production setup guide](/docs/getting_started/production_environment) talks about how to open your production database to allow for remote connections.

To get started, **copy** `config/database.sample.yml` to `config/database.yml`.

> Be sure to *copy* and **not** *rename* the database file. It'll be easier to endure updates in the future.

Modify this file to fit your team's settings.

```yaml
development:
  adapter: mysql2
  encoding: utf8
  pool: 5
  host: [your_production_ip]
  username: [mysql_user]
  password: [mysql_pass]
  port: [mysql_port]
  socket: [path_to_socket_file]
  database: [prod_db_name]
```

### App Config

Next is the application config. Copy `config/sapwood.sample.yml` to
`config/sapwood.yml`. Add a value for all the blank values, and customize
anything you wish.

[Learn more about this file](/docs/getting_started/the_configuration_file).

> *DEPRECATION NOTICE: This file is being deprecated in an upcoming release. At that time, settings will be stored in the database.*

Get Up and Running
----------------

Install the gems using Bundler.

```text
$ bundle install
```

This is likely where you will run into issues if you don't have all the necessary dependencies. If you can't debug the issue locally, feel free to [create an issue](https://github.com/seancdavis/sapwood/issues/new) if you're stuck.

> **WARNING: You should not execute any database commands from within development, as they may destructively alter your live app.**

That's It!
----------------

Once your bundle is installed, your development is ready to go. Start your rails server and get to work!

While the content will show up immediately (assuming you have a production instance running), you will need to import the git repos as needed. See [Working with Git](/docs/communicative_workflow/working_with_git) for more information.
