[Rake tasks](https://github.com/ruby/rake) are a great way to automate repeated tasks. We continue to add rake tasks to the Sapwood project to make it easier to work with.

> If you have an idea for a task that should be added to Sapwood, add it!

The `utilities/tasks.rake` file is for building site-specific rake tasks. And, frankly, that's about where this discussion ends. Anything you need to do for that site, add it to your `tasks.rake` file and voila!

The only recommendation of any importance is that you namespace your tasks with your (underscored) project slug.

```ruby
namespace :my_site do
  desc 'My first task'
  task :my_first_task => :environment do
  end
end
```

That task would then be accessible by running the following command.

```text
$ bundle exec rake my_site:my_first_task
```

This simple helps avoid conflict with other tasks.

At any time, you can see all available tasks by running:

```text
$ bundle exec rake -vT
```
