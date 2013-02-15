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
#= require bootstrap-combobox
#= require bootstrap-typeahead

String.prototype.capitalize = ->
  return this.charAt(0).toUpperCase() + this.slice(1);

setEventsForPjax = ->
  $("a[rel=popover]").popover()
  $('.combobox').combobox(items: 10)
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  $('.alert').alert()
  $('input, textarea').placeholder() if typeof($().placeholder) == typeof(Function)

  $('#note-modal').on('hidden', ->
    $(this).data('modal').$element.removeData();
  )

  $('.beer-actions button').tooltip
    html: false
    delay:
      show: 500

  # Yes, there's considerable duplication here. However, trying to alleviate
  # that led to what I believed to be some pretty unreadable CoffeeScript, and
  # I prefer readability to terseness.
  $('.beer-actions button').click ->
    action = $(this).attr('data-action')
    id     = $(this).attr('data-id')

    switch action
      when 'note'
        $('#note-modal').modal
          backdrop: 'static'
          keyboard: true
          remote:   "/beers/#{id}/note"
      when 'like'
        $.ajax("/beers/#{id}/like",
          type: 'POST'
          success: (data) =>
            $(this).addClass('btn-success')
            $(this).attr('data-action', 'unlike')
            $(this).attr('data-original-title', 'Unlike')

            count = parseInt $(this).children('span.like-count').html()
            $(this).children('span.like-count').html(count + 1)

            $(this).siblings().prop('disabled', true)
            $(this).siblings('.fridge-button').prop('disabled', false)
        )
      when 'unlike'
        $.ajax("/beers/#{id}/like",
          type: 'DELETE'
          success: (data) =>
            $(this).removeClass('btn-success')
            $(this).attr('data-action', 'like')
            $(this).attr('data-original-title', 'Like')

            count = parseInt $(this).children('span.like-count').html()
            $(this).children('span.like-count').html(count - 1)

            $(this).siblings().prop('disabled', false)
        )
      when 'dislike'
        $.ajax("/beers/#{id}/dislike",
          type: 'POST'
          success: (data) =>
            $(this).addClass('btn-danger')
            $(this).attr('data-action', 'undislike')
            $(this).attr('data-original-title', 'Undislike')

            count = parseInt $(this).children('span.dislike-count').html()
            $(this).children('span.dislike-count').html(count + 1)

            $(this).siblings().prop('disabled', true)
            $(this).siblings('.fridge-button').prop('disabled', false)
        )
      when 'undislike'
        $.ajax("/beers/#{id}/dislike",
          type: 'DELETE'
          success: (data) =>
            $(this).removeClass('btn-danger')
            $(this).attr('data-action', 'dislike')
            $(this).attr('data-original-title', 'Dislike')

            count = parseInt $(this).children('span.dislike-count').html()
            $(this).children('span.dislike-count').html(count - 1)

            $(this).siblings().prop('disabled', false)
        )
      when 'bookmark'
        $.ajax("/beers/#{id}/bookmark",
          type: 'POST'
          success: (data) =>
            $(this).addClass('btn-primary')
            $(this).attr('data-action', 'unbookmark')
            $(this).attr('data-original-title', 'Remove from fridge')

            $(this).siblings('.hide-button').prop('disabled', true)
        )
      when 'unbookmark'
        $.ajax("/beers/#{id}/bookmark",
          type: 'DELETE'
          success: (data) =>
            $(this).removeClass('btn-primary')
            $(this).attr('data-action', 'bookmark')
            $(this).attr('data-original-title', 'Put in fridge')

            $(this).siblings().prop('disabled', false)
        )
      when 'hide'
        $.ajax("/beers/#{id}/hide",
          type: 'POST'
          success: (data) =>
            $(this).addClass('btn-warning')
            $(this).attr('data-action', 'unhide')
            $(this).attr('data-original-title', 'Unhide')

            $(this).siblings().prop('disabled', true)
        )
      when 'unhide'
        $.ajax("/beers/#{id}/hide",
          type: 'DELETE'
          success: (data) =>
            $(this).removeClass('btn-warning')
            $(this).attr('data-action', 'hide')
            $(this).attr('data-original-title', 'Hide')

            $(this).siblings().prop('disabled', false)
        )

$ ->
  setEventsForPjax()

  $('[data-pjax-container]')
    .pjax('a:not([data-remote]):not([data-method]):not([data-behavior]):not([data-skip-pjax])')
    .on('pjax:success', ->
      setEventsForPjax()
    )
