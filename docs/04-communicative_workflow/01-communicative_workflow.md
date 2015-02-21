Sapwood is built around the idea of a Communicative Workflow. This workflow enables you to build unique and fully customized sites from the ground up, all while working in a team.

Development vs. Production
----------------

In Sapwood, like most web development projects, the *development* environment means *an instance of the entire application that runs locally on your machine or one of your team member's machines*. There can be as many of these instances as you need -- likely equal to the number of team members.

The *production* environment is *the one instance of Sapwood that hosts the final versions of your sites*. Production is accessible via a specific domain name.

And while *there is only one production environment*, you *could* create more than one. In that case, they would operate separately from each other.

Content Flow
----------------

Since v1.1, content does not *flow* at all. It simply *lives* in production. There is no more syncing or worrying about staying updated with production. If you connect your databases correctly, then you any content you interact with is live in production.

Because of this, pages that are in *DRAFT* status are not viewable by the public in production. However, your development app will see them. It is for this reason that you can add sections to your site even after the site is live.

Code Flow
----------------

The code flows as it normally would in a rails project. You develop and test locally, and then you *"deploy" to production*. You and your teammates use git, along with some features of the UI to stay up to date with the latest code (and to track your changes).

Git is explained in more detail in [this section](/docs/communicative_workflow/working_with_git).

Content Determines Code
----------------

**Content determines code**. That means the way in which you build the content determines how you **must** build the code if you want your site to be error-free.

This is explained much more fully in [Building Content](/docs/building_content).

Future Versions
----------------

A big part of building content effectively is to have full access to and knowledge of the Sapwood API. In this version of the docs, you can find the items you need to be able to build a site.

That being said, the primary goal of v2.0 is to get more organized and provide a full API reference. [Let us know](mailto:sean@rocktree.us) if you'd like to contribute.
