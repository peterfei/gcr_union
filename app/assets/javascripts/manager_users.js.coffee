# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  if $('#manager_user_role').val() == 'oprator'
    $('.hide').show()
  $('body').on "change", '#manager_user_role', ->
    if $(@).val()=='oprator'
      $('.hide').show()
    else
      $('.hide').hide()
