Sapwood works best when you follow our [communicative workflow](/docs/communicative_workflow). This means we have one production server from which the content is being generated, and potentially several development environments using that content in their own instance.

Let's look at how to get a development environment setup.

Requirements
----------------

Really, any computer will work fine, so long as you can run ruby projects on this. For the sake of making this article brief, we're going to assume **you know how to run a Ruby on Rails application on your machine.**

This also means that Windows is not the ideal operating system, although it's *possible* it could work.

You don't need a ton of power or space to run this application, especially if you are hosting your uploaded assets remotely.

Here's what you should need:

* Ruby 2.1
* Git
* MySQL
* ImageMagick
* Qt

If you have all the packages required to use the programs listed above, then you should be good to go.

Clone Repo
----------------

We're assuming you've run a Ruby on Rails project before, since Sapwood involves developing with Rails in Ruby. This means you probably have a directory in which you like to store your projects. If you don't, it really doesn't matter where you decide to put the project. Most people create a directory within their home directory, called whatever they prefer -- `sites`, `www`, `code`, `apps`, etc. It's your choice.

Go into that directory and then clone the repository from GitHub.

```text
$ cd /path/to/your/codes
$ git clone https://github.com/seancdavis/sapwood.git -b v1-stable
```

> Note: Notice here we are specifically cloning the `v1-stable` branch of the sapwood repo. This will help us stay up to date with the most recent stable version of the code.

Configure Application
----------------

We have a few things to configure before we can be up and running. First, your
database.

### Database

With our handy-dandy workflow, you're able to use a local database copy of your production database, which means you can test things out and break them without affecting your teammates' instance of a project.

Copy `config/database.sample.yml` to `config/database.yml`.

Modify this file to fit your local settings. Usually, it'll look something like this, but you can change as needed.

```yaml
development:
  adapter: mysql2
  encoding: utf8
  pool: 5
  username: root
  password: root
  database: sapwood_development
  socket: /tmp/mysql.sock
```

> Note: You may need to change the socket path, depending on the way in which you installed MySQL.

### App Config

Next is the application config. Copy `config/sapwood.sample.yml` to
`config/sapwood.yml`. Add a value for all the blank values, and customize
anything you wish.

Learn more about this file [here](/docs/getting_started/the_configuration_file).

Get Up and Running
----------------

Install the gems using Bundler.

```text
$ bundle install
```

Then, create and migrate your database.

```text
$ bundle exec rake db:create
$ bundle exec rake db:migrate
```

That's It!
----------------

That's it. That wasn't so bad, was it?

If you already have a production server running with Sapwood, it's time to sync. You can learn about that in the [content workflow chapter](/docs/communicative_workflow).

If you don't have a production server ready, you'll want it for generating content. [Move on to the production environment section](/docs/getting_started/production_environment).
