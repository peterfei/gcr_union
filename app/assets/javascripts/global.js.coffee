jQuery ->
  #$('body').on 'hidden', '.modal', ->
  #  $(@).removeData('modal')
  #$('.datepicker').on 'click', (e) ->
  #  options =
  #    dateFmt: 'yyyy-MM-dd'
  #    autoPickDate: null
  #  WdatePicker $.extend options, $(@).data()
  $('#myModal').on 'shown',->
    $('form[data-validate]').validate()

  #$('.datetimepicker').on 'click', (e) ->
  #  options =
  #    dateFmt: 'yyyy-MM-dd HH:mm:ss'
  #    autoPickDate: null
  #  WdatePicker $.extend options, $(@).data()

  #$("a[rel=popover]").popover()
  #$(".tooltip").tooltip()
  #$("a[rel=tooltip]").tooltip()
  # 初始化页面中的 select
  $('body').init_components()
  $('.alert').delay(1000).slideUp()
  #protocol = (if window.location.protocol is "http:" then "ws://" else "wss://")
  #address = protocol + window.location.host + window.location.pathname + "/ws"
  #socket = new WebSocket(address)
  #socket.onmessage = (msg) ->
  #  msg.data is "reload" and window.location.reload() 
  $('.datepicker').datepicker
    format: 'yyyy-mm-dd'
    language: 'zh-CN'
    autoclose: true
