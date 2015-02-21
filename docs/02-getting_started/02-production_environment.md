In the [communicative workflow](/docs/communicative_workflow) chapter, you will learn that all content revolves around one production instance of the app. It is both the place you build the content structure of your sites, but it is also the app that hosts the live versions of the sites you build.

> This guide is really only for one developer on your team. You should only need one production instance of Sapwood, and therefore you only need to do this one time. If this is already setup for your team, then head over and get [your local environment up and running](/docs/getting_started/development_environment).

Let's look at how to setup your production server, and get Sapwood running on the server.

Like the rest of these guides, this assumes you know your way around a Ruby on Rails project. This section, in particular, assumes you've had to deploy a RoR project.

Server Requirements
----------------

### Choosing A Server

If your experience in deploying projects is strictly using Heroku or a shared environment like you have with Bluehost, then you'll need to change a bit here. This guide covers installing Sapwood on **a dedicated private server**. Shared servers and Heroku are not supported.

If that sounds expensive, it's because it usually is. Fortunately, there are some awesome companies like [Digital Ocean](https://www.digitalocean.com) popping up. Digital Ocean offers dedicated, virtual private servers [starting at $5 per month](https://www.digitalocean.com/pricing).

### Operating System

Sapwood will work wherever you can run a Ruby on Rails project. For reference, I develop on Mac OS X Yosemite, while my production servers run Ubuntu 14.04.

**For this guide, we're going to assume you're working with an Ubuntu/Debian installation.** Obviously, you can use Sapwood in production with other operating systems, but you'll have to find the equivalent packages.

### Minimum Specifications

The minimum specs for your server are somewhat open-ended. Obviously, the faster the better, but here's what I am running.

* Ubuntu 14.04 x64
* 1GB RAM
* 4GB Swapfile
* 30GB SSD Disk
* 1 CPU

> While Rails is scalable, it takes some extra configuration with your web server and perhaps multiple machines. This isn't shown here and a concurrency scenario hasn't yet been tested.
>
> Therefore, if you have a high-traffic site you are going to build using Sapwood, I'd love to hear your story and the obstacles you overcame.
>
> This also means Sapwood doesn't guarantee mileage with high-traffic sites. One production instance of Sapwood is known to be running 5 small sites, and still performing (subjectively) well. Caching and concurrency are on the roadmap.

Server Preparation
----------------

### Required Packages/Programs

At this point, we're assuming you know how to prepare a production server.

> If you've never done this sort of thing before, then check out my [one-command install script](https://github.com/rocktree/ripen).

You will need the ensure the following is true on your machine.

* `deploy` user with full `sudo` privileges
* ssh access to the server on any port

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

It's easiest if your server has its own Git identity. We recommend creating a unique key for each server that has a unique sapwood installation, as it makes them easier to manage and it's a little more secure.

First, ensure you don't already have a key.

```text
$ ls -al ~/.ssh
```

If you don't see an `id_rsa` and a `id_rsa.pub` file in there, then you're good to go.

Following [the GitHub tutorial](https://help.github.com/articles/generating-ssh-keys), let's generate the key.

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

> *NOTICE: While it is typically recommended you create the passphrase, you want to skip that step here so Git doesn't prompt us when we're running commands behind the scenes.*

Next, you'll want to ensure your server's Git identity is configured. You just need a fake name and a fake email address. Something like the following will work.

```text
$ git config --global user.name "rtcms01"
$ git config --global user.email "rtcms01@rocktree.us"
```

The last thing you should do is add that key as a deploy key on your git
server. This step could differ greatly depending on the application you use to
manage your git repositories.

Open MySQL
----------------

The communicative workflow is all about being able to talk with the production database from your development environment(s). To do that, we need to open up MySQL to allow for remote connections.

First, connect to MySQL as an all-powerful user:

```text
$ mysql -u root -p
```

You'll need to change `root` to the name of your admin user, and then provide the password.

In `mysql`, run this command:

```text
mysql> grant all on [db_name].* to [db_user]@'[your_dev_public_ip]' identified by '[db_pass]';
```

Be sure to replace all the values in brackets.

> *SECURITY NOTE: To keep yourself safer, if you always develop from one IP address, or if you only want to keep one open at a time, you can use that specific IP address. Otherwise, you can use a `%` in place of any or all of the numbers in the IP address as a wildcard selector.*

Next, note the port on which mysql is connecting and the path to the socket file. Both of these values should be listed in `/etc/mysql/my.cnf`. These values are essential to connecting a development instance.

If you are using a firewall, be sure the port mysql is using is open.


Application Setup
----------------

Now you have a working server and it's time to install Sapwood and configure some other items on your server.

### Clone Repository

First, let's make a directory for our application.

```text
$ mkdir ~/apps
```

> **WARNING: While you can place the project elsewhere if you know what you're doing, the location of the project is tied to a few of these steps.**

Next, clone the repo from GitHub.

```text
$ cd ~/apps
$ git clone https://github.com/seancdavis/sapwood.git -b release
```

> Note: This is moving you directly to the `release` branch of the project. This is the latest stable release on the current major version.

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
  username: [username]
  password: [password]
  database: [db_name]
  socket: /var/run/mysqld/mysqld.sock
```

Here, replace `[username]`, `[password]` and `[db_name]` with your values.

> Note: You're likely going to need to change the socket path from the default. If you're following this tutorial, then the socket path shown above should work fine.

### Configure App Settings

Next, let's change the general application config.

> *DEPRECATION NOTICE: The config file will be deprecated and built into the app in an upcoming release.*

```text
$ cp config/sapwood.sample.yml config/sapwood.yml
$ vim config/sapwood.yml
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
$ sudo cp lib/deploy/unicorn_init /etc/init.d/unicorn_sapwood
$ sudo cp lib/deploy/unicorn.rb config/unicorn.rb
$ sudo update-rc.d -f unicorn_sapwood defaults
```

Start the unicorn workers (your rails server).

```text
$ mkdir -p tmp/pids
$ sudo service unicorn_sapwood start
```

Add and edit the nginx configuration.

```text
$ sudo cp lib/deploy/nginx /etc/nginx/sites-enabled/sapwood
$ sudo rm /etc/nginx/sites-enabled/default
$ sudo vim /etc/nginx/sites-enabled/sapwood
```

You'll want to change and uncomment the following line to reflect the domain name you're going to use.

[file:/etc/nginx/sites-enabled/sapwood]

```nginx
# server_name cms.yourdomain.com;
```

> This is the domain name to the builder portion of the app, NOT a site you're going to create using Sapwood.

Restart nginx.

```text
$ sudo service nginx restart
```

Give It A Whirl
----------------

At this point, you should be up and running in production. If you hit a bump along the way, [let us know](https://github.com/seancdavis/sapwood/issues/new). Otherwise, you're off to the races. Check out some of the other docs on how to use sapwood.

THIS WAS A LOT!!
----------------

It is a lot to write and maintain and it's a lot to ask of you to do manually to get this thing up and running. I'd love to simplify these docs to essentially enable our users to install with just a few commands.

If you're up for the challenge, I'm looking to package the development and production installation processes into just a few scripts using a similar approach as we have with [Ripen](https://github.com/rocktree/ripen).

[Send me a note](mailto:sean@rocktree.us) if you're interested.
