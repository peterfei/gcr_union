module SelfDrivePricesHelper
  def get_range _start, _end
    range = []
    until _start > _end do
      range << _start
      _start += 1.days
    end
    range
  end

  def get_text_range range
    _start = range.first.strftime('%Y/%m/%d')
    _end   = range.last.strftime('%Y/%m/%d')
    "#{_start} - #{_end}"
  end

  def calc_range list
    range = []
    _last = nil
    list.each do |d|
      range << nil if _last and (_last + 1.days != d)
      range << d
      _last = d
    end
    range.split nil
  end
end
