class App.Views.Tabs extends Backbone.View

  el: 'body'

  events:
    'click ul.tabs a': 'tabToggle'

  initialize: ->
    if window.location.hash
      s = window.location.hash.replace('#','')
      $("section.#{s}, ul.tabs a[data-section='#{s}']").addClass('active')
    else
      $("section.tabbed").first().addClass('active')
      $("ul.tabs a").first().addClass('active')

  tabToggle: (e) ->
    e.preventDefault()
    s = $(e.target).data('section')
    $("section.tabbed, ul.tabs a").removeClass('active')
    $("section.#{s}, ul.tabs a[data-section='#{s}']").addClass('active')
    window.location.hash = s
