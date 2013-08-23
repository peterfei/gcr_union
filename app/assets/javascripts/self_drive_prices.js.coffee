Array::last = (n) ->
  if n? then @[(Math.max @length - n, 0)...] else @[@length - 1]

Array::unique = ->
  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output

jQuery ->
  $('#main').on 'click','.custome_prices_plus', ->
    _div=$(@).parent()
    _div.clone().insertAfter(_div)
    false

  $.last = []
  $('#main').on 'change', '#location_show,#car_model_show', ->
    current = $('#car_model_show').val().split(',')
    if current.length >= $.last.length

      car_model = current.last()
      car_model = 0 if current.last() == ''
      $.get("/self_drive_prices/#{car_model}?location_id=#{$('#location_show').val()}")
    else
      diff = []
      for i in $.last
        unless i in current
          diff.push i
      for i in diff
        $("#table-#{i}").fadeOut('slow',->($(@).remove()))
    $.last = current
