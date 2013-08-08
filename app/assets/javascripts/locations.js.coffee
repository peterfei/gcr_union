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
    
  #是否24小时营业
  $('#location_is24').live 'click', ->
    if $(@).attr('checked')
      $('#start_time_hour').select2('val','00')
      $('#start_time_min').select2('val','00')
      $('#end_time_hour').select2('val','23')
      $('#end_time_min').select2('val','59')
    else
      $('#start_time_hour').select2('val','08')
      $('#start_time_min').select2('val','30')
      $('#end_time_hour').select2('val','17')
      $('#end_time_min').select2('val','30')
    
  changeInputStyle = (obj,o) ->
    if o==1
      obj.css('border','2px solid #E9322D')
      obj.css('box-shadow','0 0 6px #F8B9B7')
      obj.css('color','#B94A48')
    else
      obj.css('border','1px solid #CCCCCC')
      obj.css('box-shadow','0 1px 1px rgba(0, 0, 0, 0.075) inset')
      obj.css('color','#555555')
      
  #保存按钮事件,校验开始
  $("#locationOfSaveBtn").live 'click', ->
    issub = true
    location_location_name = $("#location_location_name")
    location_phone = $("#location_phone")
    pickup_city = $("#pickup_city")
    pickup_district = $("#pickup_district")
    location_principal = $("#location_principal")
    location_principal_phone = $("#location_principal_phone")
    
    if location_location_name.val()=='' or !isNaN(location_location_name.val())
      changeInputStyle(location_location_name,1)
      issub = false
    else
      changeInputStyle(location_location_name,0)
      
    if location_phone.val()=='' or isNaN(location_phone.val()) or location_phone.val().length<11
      changeInputStyle(location_phone,1)
      issub = false
    else
      changeInputStyle(location_phone,0)
      
    if pickup_city.val()==''
      changeInputStyle(pickup_city,1)
      issub = false
    else
      changeInputStyle(pickup_city,0)
      
    if pickup_district.val()==''
      changeInputStyle(pickup_district,1)
      issub = false
    else
      changeInputStyle(pickup_district,0)
      
    if location_principal.val()==''
      changeInputStyle(location_principal,1)
      issub = false
    else
      changeInputStyle(location_principal,0)
      
    if location_principal_phone.val()=='' or location_principal_phone.val().length<11 or isNaN(location_principal_phone.val()) 
      changeInputStyle(location_principal_phone,1)
      issub = false
    else
      changeInputStyle(location_principal_phone,0)
    if issub
      $("#location_form").submit()
