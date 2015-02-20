The `projects` directory in sapwood holds all your projects (sites) within Git submodules. This enables you to track your code changes separately for each project.

Really, though, the `projects` directory is just a holding place for the code. Nothing would function within the sapwood app if we just left it there. That's why we need to *hook into the sapwood rails app*.

Hooking Files
----------------

A project file is hooked into rails via a **comment** in this format:

```text
rtsym:[path]
```

Obviously, how you make a comment changes based on the file type, so we'll leave that up to you.

For example, if you look at the top of the `templates/layout.html.erb` file, you see this:

```erb
<%# rtsym:app/views/layouts/viewer/[site_slug].html.erb %>
```

When symlinks are generated, this file will be symlinked to the path following the colon. The sapwood app already knows where to look for the symlink, so it is there, your site will function properly.

Hooking Directories
----------------

You can also symlink an entire directory. This is done through a `.symlink` file within that directory.

The `.symlink` file's entire contents are to be the path to which the directory should be linked.


WARNING! Changing Defaults
----------------

This documentation is here simply so you know what these files and these parts of files are doing. In other words, we're telling you **they are important, don't delete them**.

But that also doesn't mean you should change them. While you are free to hook into rails *wherever* you'd like, you should know that it is important you follow the steps above when customizing anything. **The sapwood app is tightly configured to a certain set of expectations; changing the location of a symlink can have damaging effects on your site and possibly the entire sapwood app**.

That being said, there are times when it might make sense to symlink a file. For example, if you have a lot of rake tasks and you want to organize them into individual files, you'll need a symlink for each file.

When adding symlinks, follow the steps above and **ensure you aren't conflicting with another site's symlink location**.

