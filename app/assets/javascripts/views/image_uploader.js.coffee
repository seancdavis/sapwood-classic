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
        $('section.data-table').before(data.context)
        data.submit()
        console.log data
      progress: (e, data) ->
        if data.context
          progress = parseInt(data.loaded / data.total * 100, 10)
          data.context.find('.bar').css('width', progress + '%')
      done: (e, data) ->
        data.context.remove()
        console.log window.location
        $.get window.location.pathname, (data) ->
          $('section.data-table').html(data)
      fail: (e, data) ->
        console.log 'FAIL'
        console.log e
        console.log data

  toggleForm: (e) ->
    e.preventDefault()
    $('#image_image').click()
