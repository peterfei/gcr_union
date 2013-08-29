$('#main').html("<%= j(render('form'))%>")
$('body').init_components()
<%-if @manager_user.role=='oprator'%>
$('.hide').show()
<%end%>
