# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#myTab a:first').tab('show')
  $('#reservation_base_rate_code_id,#self_driving_base_rate_code_id').change ->
    $.ajax '/consultation',
      data: $('form').serialize()
      type: "GET"
      dataType: 'script'
  $('#reservation_pickup_city_id,#self_driving_pickup_city_id').change ->
    $('#reservation_return_city_id,#self_driving_return_city_id').select2('val',$(@).val())
  $('#self_driving_pickup_location_id').change ->
    $('#self_driving_return_location_id').select2('val',$(@).val())
  $('#reservation_car_type_id,#reservation_compound_return_date_attributes_time,#self_driving_compound_return_date_attributes_time,#car_id').change ->
    rate_code =  $('#reservation_base_rate_code_id').data('rate_code') 
    unless rate_code
      rate_code = $('#self_driving_base_rate_code_id').data('rate_code')
    #if rate_code!='ZJ'
    $.ajax url:"/consultation",data: $('form').serialize(),dataType:'json',success:(data)->
      $('#base_rate').val data?.base_rate?.base_rate
      $('#compute_price').val(data?.total_price)
      
        
      #console.log rate_code
      #compute_price = 
  $('input:checkbox[name="reservation[special_requirements][]"],#reservation_use_day,#reservation_use_hour').change ->
    rate_code =  $('#reservation_base_rate_code_id').data('rate_code')
    if rate_code!='ZJ'
      $.ajax url:"/consultation",data: $('form').serialize(),dataType:'json',success:(data)->
        if  "en_driver"  in data?.special_requirements
          $('#special_requirements_en_driver').val(100)
        else
          $('#special_requirements_en_driver').val(0)
        if "waiting_card" in data?.special_requirements
          $('#special_requirements_waiting_card').val(100)
        else
          $('#special_requirements_waiting_card').val(0)
        $('#base_rate').val data?.base_rate?.base_rate
        $('#compute_price').val(data?.total_price)
  $('#get_price').on 'click',() ->
    $.ajax '/consultation',
      data: $('form').serialize()
      type: "GET"
      dataType: 'script'
    
  $('#reservation_airline').change ->
    span=$("<span><span>")
    if $(@).val()!=''
      $.getJSON "/flights/#{$(@).val()}",(data)=>
        #console.log data
        if !!data.success
          span.text "航班#{$(@).val()}将于#{data.flight.due_takeoff_time}在#{data.flight.takeoff_airport}起飞" 
          #console.log "航班#{$(@).val()}将于#{data.flight.due_takeoff_time}在#{data.flight.takeoff_airport}起飞" 
    span.appendTo($('.reservation_airline'))

  $('#same_as_current_user').change ->
    if $(@).prop('checked')
      $('#reservation_passenger_phone').val $('#reservation_reservation_person_phone').val()
      $('#self_driving_passenger_phone').val $('#self_driving_reservation_person_phone').val()
    else
      $('#reservation_passenger_phone').val('')
      $('#self_driving_passenger_phone').val('')
  # 接送业务默认结束时间计算
  $('#reservation_compound_pickup_date_attributes_date').change ->
    $('#reservation_compound_return_date_attributes_date').val $(@).val()
  $('#reservation_compound_pickup_date_attributes_time').change ->
    if $('#reservation_compound_pickup_date_attributes_date').val()
      time = "#{$('#reservation_compound_pickup_date_attributes_date').val()} #{$('#reservation_compound_pickup_date_attributes_time').val()}"
      console.log time
      time=moment(time,'YYYY-MM-DD HH:mm').add('minutes',90)
      $('#reservation_compound_return_date_attributes_date').val time.format('YYYY-MM-DD')
      $('#reservation_compound_return_date_attributes_time').val time.format('HH:mm')
