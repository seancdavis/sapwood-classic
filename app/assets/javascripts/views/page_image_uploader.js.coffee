class App.Views.PageImageUploader extends Backbone.View

  el: 'body'

  events:
    'click .image-upload-trigger': 'triggerUploader'

  initialize: (options) ->
    @site = options.site
    @ajaxPage = new App.Views.AjaxPage

  triggerUploader: (e) ->
    e.preventDefault()
    $.get "/sites/#{@site}/images?content_only=true", (data) =>
      @ajaxPage.loadContent(data)


