$('<div class="alert alert-error"></div>').text('<%=@cars.map{|c| c.errors.full_messages}.uniq.join('， ')%>').prependTo('#main').delay(4000).slideUp()
