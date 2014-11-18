class App.Views.FileUploader extends Backbone.View

  el: 'body'

  initialize: ->
    @initUploaders()

  initUploaders: ->
    for uploader in $('.file-upload')
      $(uploader).fileupload
        add: (e, data) ->
          # data.submit()
          console.log '123'
        success: (image) =>
          console.log image
          # @toolbars.image.find('div.image-library').prepend(@imageTemplate(image: image))
          # @toolbars.image.find('#image-url').val(image.url)
          # @toolbars.image.find('#image-alt').focus()
          # @toolbars.image.scrollTop(0)