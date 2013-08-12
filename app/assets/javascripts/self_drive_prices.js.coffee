Array::last = (n) ->
  if n? then @[(Math.max @length - n, 0)...] else @[@length - 1]

Array::unique = ->
  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output

jQuery ->
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
            url: 'asdfasdf'
          }
          true
        )
        $('#calendar').fullCalendar('unselect')
    events: []
  )

  $.days_and_prices = ->
    days=[]
    prices = []
    $($('#calendar').fullCalendar('clientEvents')).each (i,event)->
      start = moment event.start
      end   = moment event.end
      
      end = start unless end
      for i in [0 .. end.diff(start,'days')]
        _day = start.add('days',i&&1).format('YYYY-MM-DD')
        if ($.inArray(_day, days) == -1)
          days.push(_day)
          prices.push event.prices
    [days, prices]
