Roadmap
=============

For now, we're going to keep the roadmap packaged with the project. The purpose
of this file is to keep from building out the nuances of each minor release in
the issue tracker until they are going to be worked on.

To submit an idea, please [create an
issue](https://github.com/seancdavis/taproot/issues/new) prepended with
`Request: `.

v1.2: Pages, Templates & Users (March 2015)
-------------

*Further enhancements to pages and templates, while working to separate
developers from site users. It is believed honing in on the page/template UI
will make make other enhancements quicker and easier.*

#### Quick File Improvements

Uploading to Amazon S3 is nice because there is no max capacity. However,
Sapwood isn't built to be a file management solution. And because of that,
we're transitioning to local file storage. This will keep things much simpler
and make Sapwood a little easier to work with for beginners.

The plan is to also add a max file size, so you can adjust to your needs.

#### Linking Pages and Templates

As we use the new page and template sections of the site, we'll find some items
we need to add to make them easier to navigate.

#### Surfacing & Organizing Data

There is a lot of data when it comes to pages, templates and template fields.
Surfacing important data on index views will make knowing what you're looking
at much easier to understand.

#### Quick Edit for Template Fields

To be able to move template fields around and edit some simplistic data without
going into a form will save huge amounts of time in building out custom
templates.

#### Site User Focus

Site users will have a narrower focus within the app. If they only have one
site, they will be take to that site. And then, when within a site, they will
not see the builder nav, but will only be able to navigate pages.

This separates the roles of developers and content editors, and can serve as a
catch-all permission solution until there is a need for a more robust system.

v1.3: Potpourri (April 2015)
-------------

*Adds some odds and ends to make the builder a little easier to use.*

#### Custom Error Pages

We are going to trap `404` and `500` errors on a site and allow you to add
custom error pages that use each site's stylesheets. Future default templates
will come packaged with these

#### Default Template Updates

We have some small updates to make to our default template, including a better
asset setup and some default template views.

#### Developer Help Pages

v1.1 added a couple developer help pages to read dynamic content and help
developers learn how to access that content. Now it's time to make these pages
a little easier to use and to add more content to them.

#### API Enhancements

A few methods will be added to the API to enhance the workflow. This is likely
only to include updating pages via a webhook.

v1.4: Blogging (May 2015)
-------------

*Adds features to make it easier (possible) to build and manage blog sites.*

#### Tags

Tags are crucial to using this project as a blog site builder and manager. Tags
will be managed at a site level, but created on the fly with an autocomplete
feature.

#### Related Content

What can also be helpful in a blog site is the ability to link related content.
We'll start very simplistically in this release, with plans to enhance in the
future.

#### Searching

Searching will be a necessary component of both the builder and the viewer. A
search feature will be added to the builder, and methods will be made available
for having a search results page through the viewer.

v1.5: File Management (June 2015)
-------------

*Dives into file management and works on enhancing the media library.*

#### Galleries/Category

Files will be able to be grouped together for better organization for your
site's files.

#### File Attributes

You will be able to capture and customize much more information about a file
you upload.

#### Developer Helpers

Like pages and template, there will be a developer helper page added to a
particular asset so you know how to use or manipulate the file.

#### Cropper UI

The file cropper settings are tucked away and difficult to find. They will be
moved to the media library, and the process of cropping will be made a little
cleaner.

v1.6: Workflow Enhancements (July 2015)
-------------

*Takes another steps at optimizing the site-building workflow.*

#### Page & Template Workflow (TBD)

Pending feedback from pre-v1.5 releases, the workflow will be adjusted to make
it faster to build a site from the ground up.

#### Text Editing

The rich text editor is going away, and the markdown editor will be
significantly enhanced. More than likely, it will be wrapped up in a javascript
library and plugged back in to the site.

This will come with an embedded editor for quick edits, but with the option to
launch the full-screen window.

#### Markdown Editing for Dynamic Fields

Sometimes you need more than one field for rich text editing on a given
template. This will give you that option.

#### App & Site Settings

All settings will be brought into the database and managed from the production
version of the application. This way installations will be similar throughout.

#### API Enhancements (TBD)

It is expected more API enhancements will be desired, and they will be packaged
in this release.

v1.7: Potpourri (August 2015)
-------------

This is a placeholder for odds and ends, at least until they are able to be
separated or built. It's possible these features get implemented earlier. It's
also possible they get pushed to post-2.0.

#### Viewer Toolbar

The viewer will look for a developer to be logged in and will show a toolbar if
so. That will contain useful information and links related to the
`current_page` object.

#### Form Enhancements

With all other features of the builder being touched and transformed throughout
v1, forms will feel out of place. While they aren't used nearly as much as the
other sections, they should become more integrated in the workflow, and more
tightly tied to pages and/or templates.

v2.0 (2016)
-------------

v2.0 is the first non-backward-compatible release. It involves reorganization
and refactoring of v1 code. This organization is expected to lead to a full API
reference.

#### UI Cleanup

The builder will have been patched and enhanced throughout v1 without much
regard to the big picture. v2 will come out of the gate with a cohesive
reworking of the builder UI.

#### Decorators

Decorators will be explored and likely added as a way to organize the API and
separate view helper, logical markup and model methods.

#### API Reference

v2 is expected to coincide with a full reference to this project's API. This
will be added to the doc site.

#### Full Feature Test Suite

This project is going to move forward while relying on feature tests, and only
adding unit tests where they are not otherwise encompassed or used by a feature
test.

v2.0+ (Ideas)
-------------

This is the holding ground for ideas beyond the current roadmap. Each of these
ideas is expected to be implemented eventually, just not within the current
roadmap.

#### Google Analytics Integration

Each site should have a Google Analytics setting, which will then share the
output that should be included in the layout template. It will also come with a
simplified dashboard measuring the site's traffic.

#### Site Dashboard

After 2.0 is released, a site is expected to have enough data associated with
it that a dashboard could be created as a snapshot of the site, and provide
different jumping off points.

#### User Activity

In an effort to make it more social, an activity feed will share user
activities throughout the site.

This will also come packaged with a notification system, the features of which
are TBD.

#### Themes or Starter Projects

To jump start repeatable projects, there may be a template library from which a
user can start with files that already have them up and running.

It is TBD whether this will include a content structure or just site files. It
is also TBD whether these are built on the fly within the app or part of the
distributed product.
