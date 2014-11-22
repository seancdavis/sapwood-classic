class App.Views.PageImageUploader extends Backbone.View

  el: 'body'
  triggered: false

  events:
    'click .image-upload-trigger': 'triggerUploader'

  initialize: (options) ->
    @site = options.site
    @ajaxPage = new App.Views.AjaxPage

  triggerUploader: (e) ->
    e.preventDefault()
    @container = $(e.target).parents('.upload-field')
    if @triggered
      @ajaxPage.openPage()
    else
      $.get $(e.target).attr('href'), (data) =>
        @ajaxPage.loadContent('Images', data)
        $('.image a.select').click(@selectImage)
        @initUploader()
        @triggered = true

  selectImage: (e) =>
    e.preventDefault()
    idx = $(e.target).parents('article.image').attr('data-idx')
    thumb = $(e.target).parents('article.image').attr('data-thumb')
    @container.find('input').val(idx)
    @container.prepend('<img>') unless @container.find('img').length > 0
    @container.find('img').attr('src', thumb)
    @ajaxPage.closePage()

  # This can be refactored. It shares much with image_uploader.js.coffee
  # 
  # The big difference is it rebinds the click events after the file is
  # uploaded.
  # 
  initUploader: =>
    $('.upload-trigger').click (e) ->
      e.preventDefault()
      $('#image_image').click()
    $('#fileupload').fileupload
      add: (e, data) ->
        data.context = $(tmpl("template-upload", data.files[0]))
        $('section.images-container').before(data.context)
        data.submit()
      progress: (e, data) ->
        if data.context
          progress = parseInt(data.loaded / data.total * 100, 10)
          data.context.find('.bar').css('width', progress + '%')
      done: (e, data) =>
        data.context.remove()
        $.get $('#fileupload').data('reload-url'), (data) =>
          $('section.images-container').html(data)
          $('.image a.select').click(@selectImage)
      fail: (e, data) ->
        console.log 'FAIL'

