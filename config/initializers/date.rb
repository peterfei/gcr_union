class Date
  def weekend?
    sunday? || saturday?
  end
  def weekday?
    !weekend?
  end
end
