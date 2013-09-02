$('#main').html("<%= j(render('form'))%>")
<%-if @manager_user.errors.full_messages!=[]%>
$('.hide').show()
<%-end%>
$('#manager_user_role').on "change", () ->
    if $(@).val()=='oprator'
      $('.hide').show()
    else
      $('.hide').hide()
$('body').init_components()

