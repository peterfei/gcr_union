jQuery ->
  $('#calendar').fullCalendar(
    editable: true
    selectable: true
    selectHelper: true
    select: (start, end, allDay) ->
      # title = prompt('Event Title:')
      title = '已选中'
      console.log start
      console.log end
      console.log allDay
      if title
        $('#calendar').fullCalendar(
          'renderEvent'
          {
            title: title,
            start: start,
            end: end,
            allDay: allDay
          }
          true
        )
        $('#calendar').fullCalendar('unselect')
    events: []
  )

  $.getDays = ->
    days=[]
    $($('#calendar').fullCalendar('clientEvents')).each (i,event)->
      start = moment event.start
      end   = moment event.end
      DAY = 1000 * 60 * 60 * 24
      
      for i in [0 .. Math.round((end-start) / DAY)]
        _day = start.add('days',i&&1).format('YYYY-MM-DD')
        days.push(_day) if ($.inArray(_day, days) == -1)
    days
