# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('.datepicker').datepicker
    format: 'yyyy-mm-dd'
    language: 'zh-CN'
    autoclose: true
  $('#pickup_city,#return_city').pickup_city_select2()
  $('input.timepicker').timepicker({ timeFormat: 'HH:mm', interval: 30, scrollbar: true })
  $('#pickup_district,#return_district').pickup_district_select2()
  $('#driver_id').driver_info_select2()
  $('#location_id').location_select2()
  $('#car_id').car_info_select2()
