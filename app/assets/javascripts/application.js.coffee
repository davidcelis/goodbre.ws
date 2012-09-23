# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require jquery_ujs
#= require pjax
#= require twitter/bootstrap

$ ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

  # $('a:not([data-remote]):not([data-behavior]):not([data-skip-pjax])').pjax('[data-pjax-container]');

  $('.beer-actions button').click ->
    action = $(this).data('action')
    id     = $(this).data('id')

    switch action
      when 'like', 'dislike', 'stash', 'ignore'
        method = 'POST'
        newAction = "un#{action}"
      when 'unlike', 'undislike', 'unstash', 'unignore'
        method = 'DELETE'
        newAction = action.substring(2)
      else
        return

    klass = 'btn-success' if action is 'like'    or action is 'unlike'
    klass = 'btn-danger'  if action is 'dislike' or action is 'undislike'
    klass = 'btn-primary' if action is 'stash'   or action is 'unstash'
    klass = 'btn-warning' if action is 'ignore'  or action is 'unignore'

    $.ajax("/beers/#{id}/#{action}",
      method: method
      success: =>
        $(this).siblings.removeClass()
        $(this).siblings.addClass('btn')
        $(this).toggleClass(klass)
        $(this).data('action', newAction)
      error: =>
        console.log('hi'))
