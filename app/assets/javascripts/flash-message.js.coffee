# 自动消失的时间根据级别递加
TIMEOUT_MAPPINGS =
  info: 2000
  success: 3000
  warning: 4000
  error: 5000

@flash = (message, level='info', timeout=0) ->
  # 清除之前的 flash 信息
  $('.flash').remove()

  # 设置提示信息自动消失的时间
  flash_timeout = timeout or TIMEOUT_MAPPINGS[level] or 2000

  # 插入提示信息到页面中
  html = "<div class='flash flash_#{level} hide'>#{message}</div>"
  $flash = $(html).appendTo('.alert-messages').slideDown('fast')
  $flash.delay(flash_timeout).slideUp('fast') unless timeout == false
