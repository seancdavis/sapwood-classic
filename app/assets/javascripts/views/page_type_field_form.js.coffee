class App.Views.PageTypeFieldForm extends Backbone.View

  el: 'body'

  events:
    'change .field-data-type': 'toggleOptions'

  toggleOptions: (e) ->
    val = $(e.target).find('option:selected').val()
    options = $(e.target).parents('.field').find('.field-options')
    options.hide()
    options.show() if val == 'select'
