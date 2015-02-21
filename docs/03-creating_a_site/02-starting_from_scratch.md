You're ready for a new site. Maybe you've gone through wireframing or maybe you have no idea what this site even is. In any case, it's time to create a Sapwood site.

There's one very important distinction we need to make before we dig too deep in here. Following the [Communicative Workflow](/docs/communicative_workflow), content lives in your production database, while a site's code follows a more normal development cycle.

Given the workflow, it doesn't *really* matter in which environment you create the site. But it makes more sense to create it **in development**, since it's easier to debug if something goes awry.

Create Remote Repository
----------------

Let's get this out of the way first. Create *an empty* remote repository.

### An Awesome Benefit!

One awesome benefit of Sapwood is that the only files in your project repo are those unique to your project. Because of this, it's possible that you won't have any sensitive data in your files (and, really, you shouldn't track that with git anyways). And it's also unlikely that you're building some super secret app with Sapwood.

Because of this, it's *possible* that your code be public. Obviously, there's no *functional* benefit to that (other than cost), but it's possible.

> Note: If you are still looking for a good choice for hosting your code, I put wrote an article [on just that topic](http://thepolymathlab.com/free-alternatives-to-github-for-private-git-hosting).

Create the Site
----------------

Now, **in your development app**, sign in and go to the new site form (`/sites/new`). You'll notice a checkbox that says:

> "CREATE AND PUSH NEW REPO?"

Check it.

This is reading the value from `REMOTE GIT URL`. Remember, this is the URL to the empty, remote repository you just created.

Following this practice helps the app know where to push the repo after it is created. You'll know this step worked if you have code in your remote repo.

Troubleshooting
----------------

If something went wrong, before you report an issue, try these steps:

1. change into `projects/[project_slug]` directory within your Sapwood app
2. try to push (`git push origin master`)

If the code is present but you can't push, it is likely to do with your configuration. If the code is not there, then something went wrong during the process of creating the files.

If you can't pinpoint or solve the issue, [report it](https://github.com/seancdavis/sapwood/issues/new).
