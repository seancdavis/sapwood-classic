class App.Views.Header extends Backbone.View

  el: '#container > header'

  events:
    'click .site-title > a': 'toggleSiteMenu'

  toggleSiteMenu: (e) ->
    e.preventDefault()
    $('.site-title > ul').toggle()