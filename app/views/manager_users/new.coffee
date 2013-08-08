$('#main').html("<%= j(render('form')+javascript_include_tag('manager_users'))%>")
$('body').init_components()

