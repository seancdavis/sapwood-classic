class App.Views.Header extends Backbone.View

  el: '#container > header'

  events:
    'click .user-menu-trigger': 'toggleUserMenu'

  toggleUserMenu: (e) ->
    e.preventDefault()
    $('.user > ul').toggle()