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

  $('#calendar').fullCalendar(
    editable: true
    selectable: true
    selectHelper: true
    select: (start, end, allDay) ->
      prices = prompt('请输入价格')
      if prices
        $('#calendar').fullCalendar(
          'renderEvent'
          {
            title: "￥#{prices}"
            start: start
            end: end
            allDay: allDay
            prices: prices
          }
          true
        )
        $('#calendar').fullCalendar('unselect')
    events: []
  )

  $.days_and_prices = ->
    days=[]
    prices = []
    for event in $('#calendar').fullCalendar('clientEvents')
      start = moment event.start
      end   = moment event.end

      end = start unless end
      for i in [0 .. end.diff(start,'days')]
        _day = start.add('days',i&&1).format('YYYY-MM-DD')
        if ($.inArray(_day, days) == -1)
          days.push(_day)
          prices.push event.prices
    [days, prices]

  $.init_calendar = ->
    car_model = $('.car_model_show').val()
    $.ajax({
      dataType: "json",
      url: 'self_drive_prices',
      data: {search: {car_model_id_equals: 1}}
      success: (data) ->
        console.log data
      })
