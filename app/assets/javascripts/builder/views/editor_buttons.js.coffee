class App.Views.EditorButtons extends Backbone.View

  el: 'form'

  events:
    'click a.button.markdown': 'launchMarkdownEditor'
    'click a.button.wysiwyg': 'launchWysiwygEditor'

  initialize: ->
    @mdPage = new App.Views.AjaxPage
      klass: 'markdown-editor'
    @wysiPage = new App.Views.AjaxPage
      klass: 'wysiwyg-editor'

  launchMarkdownEditor: (e) ->
    e.preventDefault()
    if $('form#markdown_editor').length > 0
      @mdPage.openPage()
    else
      $.get $(e.target).attr('href'), (data) =>
        @mdPage.loadContent('Markdown Editor', data)
        new App.Views.MarkdownEditor
          markdownField: '#page_body_md'
          wysiwygField: '#page_body'

  launchWysiwygEditor: (e) ->
    e.preventDefault()
    @mdPage.loadContent('Hello', '123')
