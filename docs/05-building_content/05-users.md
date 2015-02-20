There are two types of users of the app:

* admin users
* site users

At this time, the permissions within a site are identical. The only difference is a site user can only access the sites they have been assigned.

Creating Users
----------------

Because users are technically *content* in your sapwood app, **they should be created in production**.

Admin Users
----------------

There is currently no access to users outside the context of a particular site. However, you can edit any user within a site.

Because we can't (yet) get to users outside of a site, you should create admin users through the rails console (in production). You would do this as you normally would, but be sure to make them an admin user.

```ruby
User.create(
  :email => 'user@example.com',
  :password => 'password',
  :password_confirmation => 'password',
  :admin => true
)
```

Site Users
----------------

Site users can be created and managed through the *Users* section of a site.

