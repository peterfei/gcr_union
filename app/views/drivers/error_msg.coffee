$('<div class="alert alert-error fade in"></div>').text('<%=@drivers.map{|c| c.errors.full_messages}.uniq.join(', ')%>').prependTo('#main').fadeIn(1000).fadeOut(8000)
