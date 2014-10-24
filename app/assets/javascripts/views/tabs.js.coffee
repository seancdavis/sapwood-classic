class App.Views.Tabs extends Backbone.View

  el: 'body'

  events:
    'click ul.tabs a': 'tabToggle'

  initialize: ->
    $("section.tabbed").first().addClass('active')
    $("ul.tabs a").first().addClass('active')

  tabToggle: (e) ->
    e.preventDefault()
    s = $(e.target).data('section')
    $("section.tabbed, ul.tabs a").removeClass('active')
    $("section.#{s}, ul.tabs a[data-section='#{s}']").addClass('active')
