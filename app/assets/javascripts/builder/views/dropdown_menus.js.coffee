class App.Views.DropdownMenus extends Backbone.View

  el: 'body'

  events:
    'click a.dropdown-trigger': 'toggleDropdown'

  toggleDropdown: (e) ->
    e.preventDefault()
    $(e.target).siblings('ul').toggleClass('active')
    $(e.target).toggleClass('active')
