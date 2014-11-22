class App.Views.ImageUploader extends Backbone.View

  el: 'body'

  events:
    'click .upload-trigger': 'toggleForm'

  initialize: ->
    @initUploader()

  initUploader: ->
    $('#fileupload').fileupload
      add: (e, data) ->
        data.context = $(tmpl("template-upload", data.files[0]))
        $('section.images-container').before(data.context)
        data.submit()
      progress: (e, data) ->
        if data.context
          progress = parseInt(data.loaded / data.total * 100, 10)
          data.context.find('.bar').css('width', progress + '%')
      done: (e, data) ->
        data.context.remove()
        $.get $('#fileupload').data('reload-url'), (data) ->
          $('section.images-container').html(data)
      fail: (e, data) ->
        console.log 'FAIL'

  toggleForm: (e) ->
    e.preventDefault()
    $('#image_image').click()
