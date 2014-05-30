$(document).on 'ajaxStart', ->
  NProgress.start()
$(document).on 'ajaxComplete', ->
  NProgress.done()
$(window).load ->
  NProgress.done()

jQuery ->
  NProgress.start()
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
  # $('.alert').delay(2000).slideUp()

  $('.datepicker').datepicker
    format: 'yyyy-mm-dd'
    language: 'zh-CN'
    autoclose: true

  $('#main').on 'focus', '.date-range', ->
    $(@).daterangepicker
      format: 'YYYY/MM/DD'
  # 导航
  $(".menu ul li").hover (->
    $(this).addClass "menu_hover"
  ), ->
    $(this).removeClass "menu_hover"

  $(".menu_item").hover (->
    $(this).find("> .menu_navigation").slideDown 100
  ), ->
    $(this).find("> .menu_navigation").slideUp 100
