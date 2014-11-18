class App.Views.ImageUploader extends Backbone.View

  el: 'body'

  initialize: ->
    @initUploader()

  initUploader: ->
    $('#new_image').fileupload
      add: (e, data) ->
        data.context = $(tmpl("template-upload", data.files[0]))
        $('#new_image').append(data.context)
        data.submit()
        console.log data
      progress: (e, data) ->
        if data.context
          progress = parseInt(data.loaded / data.total * 100, 10)
          data.context.find('.bar').css('width', progress + '%')
      done: (e, data) ->
        data.context.remove()
        console.log window.location
        $.get "#{window.location.pathname}?content_only=true", (data) ->
          $('section.data-table').html(data)
      fail: (e, data) ->
        console.log 'FAIL'
        console.log e
        console.log data
