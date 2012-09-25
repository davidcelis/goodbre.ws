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
#= require jquery.pjax
#= require twitter/bootstrap

setEventsForPjax = ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

  $('.beer-actions button').click ->
    action = $(this).attr('data-action')
    id     = $(this).attr('data-id')

    switch action
      when 'like', 'dislike', 'stash', 'ignore'
        method = 'POST'
        newAction = "un#{action}"
      when 'unlike', 'undislike', 'unstash', 'unignore'
        method = 'DELETE'
        newAction = action.replace('un', '')
        action = newAction
      else
        return

    klass = 'btn-success' if action is 'like'    or action is 'unlike'
    klass = 'btn-danger'  if action is 'dislike' or action is 'undislike'
    klass = 'btn-primary' if action is 'stash'   or action is 'unstash'
    klass = 'btn-warning' if action is 'ignore'  or action is 'unignore'

    $.ajax("/beers/#{id}/#{action}",
      type: method
      success: (data) =>
        for button in $(this).siblings()
          do (button) ->
            $(button).removeClass()
            $(button).addClass('btn')
            replacement = $(button).attr('data-action').replace('un', '')
            $(button).attr('data-action', replacement)

        $(this).toggleClass(klass)
        $(this).attr('data-action', newAction)
      error: =>
        console.log('hi'))

$ ->
  setEventsForPjax()

  $('[data-pjax-container]')
    .pjax('a:not([data-remote]):not([data-method]):not([data-behavior]):not([data-skip-pjax])')
    .on('pjax:success', ->
      setEventsForPjax()
    )
