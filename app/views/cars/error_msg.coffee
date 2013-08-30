$('<div class="alert alert-error fade in"></div>').text('<%=@cars.map{|c| c.errors.full_messages}.join(',')%>').prependTo('#main').fadeIn(1000).fadeOut(8000)
