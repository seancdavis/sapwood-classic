The media library is a collection of all the files uploaded to the site.

> At this time, only image and pdf files are allowed to be uploaded.

Adding Files
----------------

Adding files is simple. Go to the library and choose "New Document." The file will be uploaded on the fly. When it's done, a thumbnail preview of the file will appear (even for pdf files).

You can also upload files on the fly from any page with a custom `file` field.

Cropping Images
----------------

You can define custom croppers in each site's settings. You give a name for the cropper and set the dimensions, and it takes place automatically.

There are a couple quirks to consider here:

* Cropping an image is only available from the media library (not directly from a page).
* The thumbnail preview for an image is auto-generated. A custom cropper will not override this, and the thumbnail will never be adjusted - it will always crop to the middle of the image.

Categorizing Files
----------------

Currently, all files are lumped together and organized by upload date. This feature will be developed throughout minor revisions to v1.0.
