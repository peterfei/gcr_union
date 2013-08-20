$('#main').on 'click','.record i', ->
  _div=$(@).parent()
  _div.clone().insertAfter(_div)
