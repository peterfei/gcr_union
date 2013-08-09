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
      console.log start
      console.log end
      console.log allDay
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

  $.getDays = ->
    days=[]
    prices = []
    $($('#calendar').fullCalendar('clientEvents')).each (i,event)->
      start = moment event.start
      end   = moment event.end
      
      if end
        for i in [0 .. end.diff(start,'days')]
          _day = start.add('days',i&&1).format('YYYY-MM-DD')
          days.push(_day) if ($.inArray(_day, days) == -1)
          prices.push event.prices
      else
          _day = start.format('YYYY-MM-DD')
          days.push(_day) if ($.inArray(_day, days) == -1)
          prices.push event.prices
    [days, prices]

  daysInEvent = (event)->
    start = moment event.start
    end   = moment event.end
    days=[]
    prices = []
    for i in [0 .. end.diff(start,'days')]
      _day = start.add('days',i&&1).format('YYYY-MM-DD')
      days.push _day
      prices
      
  $.recalcEvent = ->
    events = $('#calendar').fullCalendar('clientEvents')
    current = events.pop()
    current_days = daysInEvent current
    for e in events
      end=e.end
      start=e.start
      days=daysInEvent(e)
      allDays = days + current_days
      if allDays.unique().length != allDays.length
        console.log 1
      
