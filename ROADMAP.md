Roadmap
=============

For now, I'm going to keep the roadmap packaged with the project. The purpose
of this file is to keep from building out the nuances of each minor release in
the issue tracker until they are going to be worked on.

This document is in constant flux, and no feature mentioned is guaranteed to be
included at any point, and the timing is simply an estimate.

To submit an idea, please [create an
issue](https://github.com/seancdavis/sapwood/issues/new) and prepend it with
`[request]`.

v1.4: File Management (June 2015)
-------------

Most aspects of the builder have been given sufficient attention since their
initial release. But, other than switching to Dragonfly, we haven't done much
with the media library. This release will focus on sites' libraries.

#### Galleries / Categories

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

v1.5: Many Small Enhancements (May 2015)
-------------

With the release of v1.3, the content management portion of Sapwood is quite
extensive and flexible. It's now time to look at the builder and add some small
enhancements.

There are big changes coming to Sapwood later in 2015, but there are still some
basic features missing, and that's what we aim to add in v1.4.

#### Developer Help Pages

v1.1 added a couple developer help pages to read dynamic content and help
developers learn how to access that content. Now it's time to make these pages
a little easier to use and to add more content to them.

#### Custom Error Pages

We are going to trap `404` and `500` errors on a site and allow you to add
custom error pages that use each site's stylesheets. Future default templates
will come packaged with these.

### Form Helpers

We're going to replace form notes with helper tooltips. This should make forms
much easier to digest and show you help items only if you need them.

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

v1.6: Setup & Theming (June/July 2015)
----------

*TBD: Aims to remove some of the duplication in setup and streamlines the
writing code process.*

v1.6: Editor App (June/July 2015)
----------

*TBD: Features to make editing a site simpler.*

v1.7: Developer App & Builder API (August/September 2015)
----------

*TBD: Features to make writing code simpler.*

v2.0: Separating Functional Apps & Documentation (Late 2015)
----------

*TBD: 2.0 will introduce a fully-documented API and will be an organized
package of self-hosted applications.*
