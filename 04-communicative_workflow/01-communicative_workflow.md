taproot is built around the idea of a Communicative Workflow. This workflow enables you to build unique and fully customized sites from the ground up, all while working in a team.

Development vs. Production
----------------

We'll use the difference between these two environments to explain how to work, so it's important you understand the difference. If you've developed and deployed a web project before, you probably already get it.

In taproot, like most web development projects, a *develoment* environment means *an instance of the entire application that runs locally on your machine or one of your team member's machines*. There can be as many of these instances as you need -- likely equal to the number of members on your web team.

The *production* environment is *the one instance of taproot that hosts the final versions of your sites*. Production is accessible by the Internet and is likely tied to a specific domain name.

And while we say *there is only one production environment*, you could have certainly deployed more than one, if necessary. But our goal is that you're bringing all your sites into one application to make it easier to manage.

Content Flow
----------------

Based on this setup, it then makes sense that **content flows downhill**. What we mean is that *any real content should be created **in the production environment***.

By using content syncing methods, [explained here](/docs/communicative_workflow/syncing_content), you can easily bring your development instance up to date with production without having to run any command line tasks.

Meanwhile, any *content created for testing code* would be created in your local development environment. At this time, this content *can not be shared with your team members, or with any other development environments*.

Code Flow
----------------

In contrast to content, **code flows uphill**. You should *write your code in development environments, and "deploy" to production*. Your teammates use your remote git repository to keep their development code up to date (part of which can be done through the app).

The entire workflow is managed by using Git, which is explained in more detail in [this section](/docs/communicative_workflow/working_with_git).

Content Determines Code
----------------

Because content and code are not yet closely knit together, they rely on you understanding an expected behavior. In the most general sense, **content determines code**. In other words, the way in which you build the content determines the way in which you **must** build the code if you want the code to to work.

This is explained much more fully in [Building Content](/docs/building_content).

Future Versions
----------------

Keep in mind that the primary goal of v2.0 of taproot will be to more closely intertwine the processes of writing code and writing content. [Let us know](mailto:sean@rocktree.us) if you'd like to contribute.
