# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#drivers__location_id').select2()
  $('#main').on 'click','.driver i', ->
    _div = $(@).parent()
    _div.clone().insertAfter(_div)

