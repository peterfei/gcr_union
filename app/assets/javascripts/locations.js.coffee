# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#pickup_city,#return_city').pickup_city_select2()
  $('#pickup_district,#return_district').pickup_district_select2()
  $('#location_status').select2()
  $('.datepicker').datepicker
    format: 'yyyy-mm-dd'
    language: 'zh-CN'
    autoclose: true
