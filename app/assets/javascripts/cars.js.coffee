$('#main').on 'click','.car_car_tag i', ->
  _div=$(@).parent()
  _div.clone().insertAfter(_div)
