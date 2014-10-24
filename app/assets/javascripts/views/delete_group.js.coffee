class App.Views.DeleteGroup extends Backbone.View

  el: 'form'

  events:
    'click .tabbed > .delete': 'deleteGroup'
    'click .tabbed > .dont-delete': 'dontDeleteGroup'

  deleteGroup: (e) ->
    e.preventDefault()
    group = $(e.target).data('group')
    groups = $('#page_type_delete_group').val().split(',')
    unless groups.indexOf(group) >= 0
      groups.push(group)
      $('#page_type_delete_group').val(groups.join(','))
    $("ul.tabs a[data-section='#{group}']").addClass('to-delete')
    $(e.target).text("Don't delete")
    $(e.target).toggleClass("delete dont-delete")

  dontDeleteGroup: (e) ->
    e.preventDefault()
    group = $(e.target).data('group')
    groups = $('#page_type_delete_group').val().split(',')
    if groups.indexOf(group) >= 0
      groups.splice(groups.indexOf(group))
      $('#page_type_delete_group').val(groups.join(','))
    $("ul.tabs a[data-section='#{group}']").removeClass('to-delete')
    $(e.target).text("Delete")
    $(e.target).toggleClass("delete dont-delete")
