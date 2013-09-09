# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$('#main').on 'click','i', ->
  _div=$(@).parent()
  console.log _div.parent().find('div:last')
  index = +_div.parent().find('div:last input:first').attr('name').match(/\d+/)[0]
  div = _div.clone()
  range_intput = div.find('input:first')
  range_intput.attr 'name', range_intput.attr('name').replace(index, index + 1)
  price_intput = div.find('input:last')
  price_intput.attr 'name', price_intput.attr('name').replace(index, index + 1)
  div.appendTo(_div.parent())
