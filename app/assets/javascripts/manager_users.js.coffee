# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  if $('#manager_user_role').val() == 'oprator'
    $('.hide').show()
  $('body').on "change", '#manager_user_role', ->
    if ($(@).val()=='oprator')  
    	$('.hide').show()
    	$('.distributor').hide()
    else if ($(@).val()=='distributor')
      $('.distributor').show()
      $('#company_id').select2({multiple:true})
    else
      $('.hide').hide()
      $('.distributor').hide()
