Per our [Communicative Workflow](/docs/communicative_workflow), it's important for *real content to flow downhill*. But, we've made it nice and easy to keep your development instances in sync with production.

Syncing works in three steps:

1. Dump production database.
2. Sync dump file.
3. Replace local database with sync file.

Therefore, this requires some configuration to make this work right.

Configuration
----------------

Most of the configuration happens outside the app, and then you tell the app where to look.

### Path to Backups

sapwood requires that everyone on the team can login to the remote server via ssh. It is up to someone on your team to configure this for every member.

You can connect via the `ssh` command with the *user-at-ip* method. In other words, something like this.

```text
$ ssh deploy@192.168.1.5
```

If you've followed our [production setup guide](/docs/getting_started/production environment), then your database dump will be placed in `~/apps/sapwood/db/backups`, and it will be named for your database.

So, bringing this all together, your `db_backup_file` is:

```text
[ssh_login]:~/apps/sapwood/db/backups/[database_name].sql
```

So, if we use `deploy@192.168.1.5` for `ssh_login` and our database name is `sapwood_production` (which you'd find in `~/apps/sapwood/config/database.yml` on the server), then our `db_backup_file` is:

```text
deploy@192.168.1.5:~/apps/sapwood/db/backups/sapwood_production.sql
```

Add this to your `config/sapwood.yml` file in development.

### API Access

To automatically dump the data, we need API access to the production app. This requires you filling out `api.public_key` and `remote.url` in [the `sapwood.yml` file](/docs/getting_started/the_configuration_file).

`remote.url` needs to be the domain at which the sapwood production app is accessed.

`api.public_key` can be any hash. Make it long. If you want, you can generate it in the console.

```text
$ bundle exec rails c

irb(main):001:0> SecureRandom.hex(16)
=> "71129c3cdb5c55f1dbea9eb2380efe74"
```

> **What is most important here is that whatever your key is, it is shared with all instances of this application on your team - every development and production environment.**

Syncing Content
----------------

### Via App

Syncing is quite easy. If you're configured correctly, go to the settings for a particular site and choose 'Sync Content'.

Do note, to insist on this workflow, the sync content option is one way and is only available in development.

### Command Line

If you're already on the command line, you can accomplish the same thing via a rake task.

```text
$ bundle exec rake sapwood:db:sync
```

> If you add or change your configuration, don't forget to restart your rails server for the new values to come into play.

