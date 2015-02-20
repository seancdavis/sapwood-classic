Given our handy-dandy [communicative workflow](/docs/communicative_workflow), your production environment is where your content will be generated. Let's look at how to setup your production server, and get taproot running on the server.

Server Requirements
----------------

### Choosing A Server

Since we are assuming you've run a Ruby on Rails project previously, we also assume you have *deployed* a Rails project.

But, even if you have, you may have used a service like Heroku, or even a shared hosting environment like Bluehost. While both of these services have benefits, to run taproot we strongly recommend **a dedicated private server**.

If that sounds expensive, it's because it usually is. Fortunately, there are some awesome companies like [Digital Ocean](https://www.digitalocean.com/) popping up. Digital Ocean offers dedicated, virtual private servers [starting at $5 per month](https://www.digitalocean.com/pricing/).

### Operating System

Taproot will work wherever you can run a Ruby on Rails project. For reference, we develop on Mac OS X machines, while our production servers are Ubuntu 14.04.

**For this guide, we're going to assume you're working with an Ubuntu/Debian installation.** Obviously, you can use Taproot in production with other operating systems, but you'll have to find the equivalent packages.

### Minimum Specifications

The minimum specs for your server are somewhat open-ended. Obviously, the faster the better, but here's what we're running:

* Ubuntu 14.04 x64
* 1GB RAM
* 4GB Swapfile
* 30GB SSD Disk
* 1 CPU

> While Rails is scalable, it takes some extra configuration with your web server and perhaps multiple machines. We aren't showing that here and we haven't yet tested a concurrency scenario.
>
> Therefore, if you have a high-traffic site you are going to build using taproot, we'd love to hear your story.
>
> This also means we can't guarantee your mileage with taproot on high-traffic sites. But, rest assured we're building sites with taproot, so we'll be looking for solutions to this problem soon enough.

Server Preparation
----------------

### Required Packages/Programs

At this point, we're assuming you know how to prepare a production server.

> If you've never done this sort of thing before, then check out our [one-command install script](https://github.com/rocktree/ripen).

You will need the ensure the following is true on your machine.

* `deploy` user with full `sudo` privileges
* ssh access to the server

We need a handful of packages. You're probably best to just run this command:

```text
$ sudo apt-get -y install build-essential zlib1g-dev libssl-dev libreadline-gplv2-dev python-software-properties make libxml2 libxml2-dev libxslt1-dev imagemagick libmagickwand-dev nodejs libmysqlclient-dev libmagic-dev
```

In addition, you need the following programs.

* [Git](http://git-scm.com/)
* [Nginx](http://nginx.org/)
* [MySQL Server](http://www.mysql.com/)
* [Ruby 2.1](https://www.ruby-lang.org/en/)
* [Bundler](http://bundler.io/)

### Configure Git

It's easiest if your server has its own Git identity. We recommend creating a unique key for each server that has a unique taproot installation, as it makes them easier to manage and it's a little more secure.

First, ensure you don't already have a key.

```text
$ ls -al ~/.ssh
```

If you don't see an `id_rsa` and a `id_rsa.pub` file in there, then you're good to go.

Following the GitHub tutorial, let's generate the key.

```text
$ ssh-keygen -t rsa -C [email_address]
```

The email address doesn't actually have to be an email address, especially for
a deploy key. You can make it unique to your server, like the following example.

```text
$ ssh-keygen -t rsa -C rtcms01
```

You'll see the following message.

```text
Enter file in which to save the key (/home/deploy/.ssh/id_rsa):
```

Just hit `enter`. That's where we want that file.

Then it asks you to create a passphrase for the private key.

```text
Enter passphrase (empty for no passphrase):
```

It's strongly recommended you create the passphrase, but you want to skip that step here so Git doesn't prompt us when we're running commands behind the scenes.

Next, you'll want to ensure your server's Git identity is configured. You just need a fake name and a fake email address. Something like the following will work.

```text
$ git config --global user.name "rtcms01"
$ git config --global user.email "rtcms01@rocktree.us"
```

The last thing you should do is add that key as a deploy key on your git
server. This step could differ greatly depending on the application you use to
manage your git repositories.

Application Setup
----------------

Now you have a working server and it's time to install taproot and configure some other items on your server.

### Clone Repository

First, let's make a directory for our application.

```text
$ mkdir ~/apps
```

> **Beware! While you can place the project elsewhere if you know what you're doing, the location of the project is tied to a few of these steps.**

Then you can clone the repo from GitHub. We're going to use the https url to clone. This is essential to ensure we can clone projects (submodules) without being logged into the server.

```text
$ cd ~/apps
$ git clone https://github.com/seancdavis/sapwood.git -b v1-stable
```

> Note: Check to ensure there isn't a more recent version of the application
> available.

### Configure Database

First, configure the database to your environment (`production` in this case).

```text
$ cp config/database.sample.yml config/database.yml
$ vim config/database.yml
```

> Note: You can use whichever editor you'd prefer. We like vim, but usually nano is easier for beginners.

We need a production database, so your config should look something like this:

[file:config/database.yml]

```yaml
production:
  adapter: mysql2
  encoding: utf8
  pool: 5
  username: root
  password: ********
  database: taproot_production
  socket: /var/run/mysqld/mysqld.sock
```

Here, replace `root`, `********` and `taproot_production` with your values.

> Note: You're likely going to need to change the socket path from the default. If you're following this tutorial, then the socket path shown above should work fine.

### Configure App Settings

Next, let's change the general application config.

```text
$ cp config/taproot.sample.yml config/taproot.yml
$ vim config/taproot.yml
```

Add a value for all the blank values, and customize anything you wish. You can learn more about this file [here](/docs/getting_started/the_configuration_file).

### Install Gems

Install the gems using Bundler.

```text
$ bundle install --without development test
```

### Create Database

Create and migrate the database.

```text
$ RAILS_ENV=production bundle exec rake db:create
$ RAILS_ENV=production bundle exec rake db:migrate
```

### Precompile Assets

Precompile the assets.

```text
$ RAILS_ENV=production bundle exec rake assets:precompile
```

### Configure Unicorn and Nginx

Move unicorn script to its proper location and update.

```text
$ sudo cp lib/deploy/unicorn_init /etc/init.d/unicorn_taproot
$ sudo cp lib/deploy/unicorn.rb config/unicorn.rb
$ sudo update-rc.d -f unicorn_taproot defaults
```

Start the unicorn workers (your rails server).

```text
$ mkdir -p tmp/pids
$ sudo service unicorn_taproot start
```

Add and edit the nginx configuration.

```text
$ sudo cp lib/deploy/nginx /etc/nginx/sites-enabled/taproot
$ sudo rm /etc/nginx/sites-enabled/default
$ sudo vim /etc/nginx/sites-enabled/taproot
```

You'll want to change the following line to reflect the domain name you're going to use. Then uncomment the line (remove the `#`).

[file:/etc/nginx/sites-enabled/taproot]

```nginx
# server_name cms.yourdomain.com;
```

Restart nginx.

```text
$ sudo service nginx restart
```

Give It A Whirl
----------------

At this point, you should be up and running in production. If you hit a bump along the way, [let us know](https://github.com/seancdavis/sapwood/issues/new). Otherwise, you're off to the races. Check out some of the other docs on how to use taproot.

THIS WAS A LOT!!
----------------

It is a lot for us to write and maintain and it's a lot to ask of you to do manually to get this thing up and running. We'd love to simplify these docs to essentially enable our users to install with just a few commands.

If you're up for the challenge, we're looking to package the development and production installation processes into just a few scripts using a similar approach as we have with [Ripen](https://github.com/rocktree/ripen).

[Send me a note](mailto:sean@rocktree.us) if you're interested.
