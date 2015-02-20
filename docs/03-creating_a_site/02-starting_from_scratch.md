You're ready for a new site. Maybe you've gone through wireframing or maybe you have no idea what this site even is. If you're in this situation, you're in the right place.

There's one very important distinction we need to make before we dig too deep in here. Following the [Communicative Workflow](/docs/communicative_workflow), content flows downhill and code flows uphill (that doesn't have to make sense, but it is described in [this chapter](/docs/communicative_workflow) if you're super curious). A rare case in which this practice will be broken is when you are first creating the site.

It is recommended that you create your site **in production**, even though it makes it a little trickier to troubleshoot.

Create Remote Repository
----------------

Let's get this out of the way first. Create a remote *and empty* repository.

### An Awesome Benefit!

One awesome benefit of taproot is that the only files in your project repo are those unique to that project. Because of this, it's quite possible that you won't have any sensitive data in your files (and, really, you shouldn't track that with git anyways). And it's also unlikely that you're building some super secret app with taproot.

Because of this, it's *possible* that your code could be public. Obviously, there's no *functional* benefit to that (other than *cost*), but it's possible.

> Note: If you are still looking for a good choice for hosting your code, the primary author of taproot has written an article [on just that topic](http://thepolymathlab.com/free-alternatives-to-github-for-private-git-hosting).

Create the Site
----------------

Now, **in your production app**, go to the new site form (`/sites/new`). You'll notice a checkbox that says:

> "CREATE AND PUSH NEW REPO?"

You want to ensure this is checked.

This is reading the value from `REMOTE GIT PATH`. **This should be the PATH to your git repo from the root of your git hosting app.** Remember, this is the empty, remote repo you just created.

Confused? Okay. Let's say my empty repository is here:

> https://github.com/seancdavis/sapwood.git

Using the path means we eliminate `https://github.com/`, and we're also going to leave off the `.git` at the end. So, my `REMOTE GIT PATH` would be:

> seancdavis/sapwood

Following this practice helps the app know where to push the repo after it is created.

You'll know this step worked if you have code in your remote repo.

Troubleshooting
----------------

If something went wrong, before you report an issue, try these steps:

1. ssh into your production server.
2. find and change into your project (inside `~/apps/taproot/projects/`)
3. try to push (`git push origin master`)

If the code is present but you can't push, it is likely to do with your configuration. If the code is not there, then something went wrong during the process of creating the files.

If you can't pinpoint or solve the issue, you should [report it](https://github.com/seancdavis/sapwood/issues/new).

Moving On
----------------

Although you could move into [content creation](/docs/communicative_workflow) at this point, you can also [bring the project down into development](/docs/creating_a_site/import_existing_site) to ensure everything looks right.
