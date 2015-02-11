Depending on your project workflow, you might not want to start out of the gate with a dynamic site. Sometimes it can be useful for your client to see some static wireframes and/or designs before you go into dynamic mode.

We have a dream to bring a static site design into the process of taproot, but that's way down the road. For now, we recommend you do it manually.

An Example
----------------

We'll give you an example of how we've worked with static development. We use [Middleman](https://middlemanapp.com/).

First, we created a middleman project within the project repository.

```text
$ middleman init middleman
```

We want to ignore the build files in middleman, so we need a gitignore file in our project's root.

```text
$ touch .gitignore
$ echo "middleman/build/" >> .gitignore
```

Then we install all the gems and get to work.

```text
$ cd middleman
$ bundle install
$ bundle exec middleman
```

The important thing to remember is we essentially **create a separate namespace within our project repository**. In other words, when we are developing statically, we are entirely in our `middleman` directory.

To give a client a public view of this static site, we manually ssh into our production server and pull the code. Something like this:

```text
$ ssh me@my_server
$ cd ~/apps/taproot/projects/[site_slug]
$ git pull origin master
$ cd middleman
$ bundle install
```

So, at this point middleman is on the production server. And now we can make the build.

```text
$ cd middleman
$ bundle exec middleman build
```

The first time we do this, we have to add a virtual host for this static site. Let's say this is going to be hosted at *staging.google.com*. I would create a file in the nginx config directory.

```text
$ sudo vim /etc/nginx/sites-enabled/staging.google.com
```

and add this content:

```nginx
server {
  listen 80;
  server_name staging.google.com;
  root /home/deploy/apps/taproot/projects/[site_slug]/middleman/build;

  index index.html;

  location / {
    try_files $uri $uri/ /index.html /index.php;
  }
}
```

Restart nginx and it should work.

```text
$ sudo service nginx restart
```

***

> If you have other examples, send your process to us. We're looking for the best example to work into the typical taproot project workflow.
