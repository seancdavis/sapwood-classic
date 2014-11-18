class App.Views.PageImageUploader extends Backbone.View

  el: 'body'

  events:
    'click .image-upload-trigger': 'triggerUploader'

  initialize: (options) ->
    @site = options.site
    @ajaxPage = new App.Views.AjaxPage

  triggerUploader: (e) ->
    e.preventDefault()
    @input = $(e.target).parents('.upload-field').find('input')
    $.get $(e.target).attr('href'), (data) =>
      @ajaxPage.loadContent('Images', data)
      $('.image a.select').click(@selectImage)

  selectImage: (e) =>
    e.preventDefault()
    src = $(e.target).parents('article.image').attr('data-src')
    @input.val(src)
    @ajaxPage.closePage()
