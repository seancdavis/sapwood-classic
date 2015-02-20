sapwood comes with a config file which helps surfaces both design and functional options for making your instance of this application unique to you.

The file is not tracked by Git, but a sample from which we work is located at `config/sapwood.sample.yml`.

How It Works
----------------

You can see the settings are broken up by environment. While you likely aren't sharing this file between environments, this at least makes it possible. It then enables you to have one config file (not tracked by Git) that can hold your development and production values.

This file is to get copied to `config/sapwood.yml` and then will become active.

The values within the environment in which you are working are loaded into the `SapwoodSetting` constant as a recursive [`OpenStruct`](http://www.ruby-doc.org/stdlib-2.0/libdoc/ostruct/rdoc/OpenStruct.html). So, for example, if you entered "Sapwood" as the site title, you could access that setting via `SapwoodSetting.site.title`.

Options
----------------

The options are grouped into semantic categories (which aren't really ordered in any particular way just yet). Let's look at each of them.

### Site

* `title`: (default: `Sapwood`) The default title for the site. This is used when we don't have a dynamic title available.
* `url`: The URL at which you will run this application. In development, this is usually `localhost`, and in production it is whatever you are using as your domain. *Note: omit the protocol and just include the domain.

### Design

This may be built out in the future, but for now we're just toggling a color palette.

#### Colors

* `primary`: (default: `099B77`) The primary color. Make this nice and bright!
* `secondary`: (default: `34495E`) Accent color that should be in good contrast to the primary color.
* `dark`: (default: `363636`) A dark color, for fonts and other dark grey accents.
* `grey`: (default: `929E9E`) A medium grey.
* `light`: (default: `FFFFFF`) A light color typically used in contrast to darker colors.

### AWS (Amazon Web Services)

Images are stored in an [AWS S3](http://aws.amazon.com/s3/) bucket. It's a nice and cheap way to keep media off your server, so you can keep your server fast and light. And if you haven't used it before, it's free for the first year.

You'll need to do the following for this to work:

* register an account with AWS
* create API keys
* create a bucket

The options following the steps above.

* `access_key_id`: API key.
* `secret_access_key`: API secret key.
* `bucket`: S3 bucket name.

### Git

This may go away as we work to using `ssh` URLs in the place of `https`, but for now this is necessary.

* `protocol`: (default: `https`) http or https
* `url`: Where you host your project repositories (without the protocol)
* `username`: The username of the app you're using for repository storage.
* `password`: The plain text password of your git app account. *Note: be sure to make this unique to other passwords*.

### Dragonfly

[Dragonfly](https://github.com/markevans/dragonfly) is the gem we use for file uploads. You don't need to configure anything here other than a unique key.

* `secret`: Just some random hash.

### Sapwood API

Sapwood has begun using an API so a development and production installation of the app can talk with each other. In other words, it's used for syncing content.

* `public_key`: Any random hash. It doesn't matter what it is, but **be sure this matches all other instances of this application that you want to talk with each other.**

### Remote

These settings are used for syncing content. These are only relevant to a development installation.

* `url`:  The url of your production app. Unlike `site.url`, this is specific to your production installation. You can leave it blank if you are in production.
* `db_backup_file`: The full ssh reference to the database backup file. This is explained much more fully in the Communicative Workflow section on [syncing content](/docs/communicative_workflow).
