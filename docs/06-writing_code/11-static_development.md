Depending on your project workflow, you might not want to start out of the gate with a dynamic site. Sometimes it can be useful for your client to see some static wireframes and/or designs before you go into dynamic mode.

Static design may become more incorporated at some point in the future. For now, you need to incorporate it manually.

An Example
----------------

Here's an example of how I've worked with static development using [Middleman](https://middlemanapp.com/).

First, create a middleman project within the project repository.

```text
$ middleman init middleman
```

We want to ignore the build files in middleman, so you need a `.gitignore` file in your project's root.

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

The important thing to remember is you need to **create a separate namespace within your project repository**. In other words, when you develop statically, you work entirely in your `middleman` directory.

To give a client a public view of this static site, manually ssh into your production server and pull the code. Something like this:

```text
$ ssh me@my_server
$ cd ~/apps/sapwood/projects/[site_slug]
$ git pull origin master
$ cd middleman
$ bundle install
```

So, at this point middleman is on the production server. And now you can make the build.

```text
$ cd middleman
$ bundle exec middleman build
```

The first time you do this, you have to add a virtual host for this static site. Let's say this is going to be hosted at *staging.google.com*. Create a file in the nginx config directory.

```text
$ sudo vim /etc/nginx/sites-enabled/staging.google.com
```

and add this content:

```nginx
server {
  listen 80;
  server_name staging.google.com;
  root /home/deploy/apps/sapwood/projects/[site_slug]/middleman/build;

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

> If you have other examples, send your process to us. We're looking for the best example to work into the typical Sapwood project workflow.
