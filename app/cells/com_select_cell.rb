class ComSelectCell < Cell::Rails

  def show args
    @show = args[:show]
    render
  end
  def field args
    @field =  args[:field]
    render
  end
end
