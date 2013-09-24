module ReservationsHelper 
  def special_requirements_text                                                                                             
    ->(l){"#{l.first}(#{number_to_currency 100})"}                                                                          
  end
end
