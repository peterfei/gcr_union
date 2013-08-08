jQuery ->
  swap_fields = ($field1, $field2, callback) ->
    if $field1.size() and $field2.size()
      $field1.css position: 'relative', zIndex: 1001
      $field2.css position: 'relative', zIndex: 1000
      $field1.animate top: '-=30px', 300, callback
      $field2.animate top: '+=30px', 300, () ->
        $field1.css position: '', top: '', zIndex: ''
        $field2.css position: '', top: '', zIndex: ''
    else
      $field1.removeClass('highlight')
      $field2.removeClass('highlight')

  $('.field_list .w_defined_lefticon').on 'click', (e) ->
    $hide_list = $('.hide_list')
    $(@).parents('li').addClass('highlight').hide 0, () ->
      $(@).find(':hidden').val('0')
      $(@).appendTo($hide_list).fadeIn ->
        $(@).removeClass('highlight')

  # 添加所有
  $('.hide_list_title .w_defined_righticon').on 'click', (e) ->
    $('.hide_list .w_defined_righticon').trigger('click')

  # 移除所有
  $('.show_list_title .w_defined_lefticon').on 'click', (e) ->
    $('.show_list .w_defined_lefticon').trigger('click')

  $('.field_list .w_defined_righticon').on 'click', (e) ->
    $show_list = $('.show_list')
    $(@).parents('li').addClass('highlight').hide 0, () ->
      $(@).find(':hidden').val('1')
      $(@).appendTo($show_list).fadeIn ->
        $(@).removeClass('highlight')

  $('.field_list .w_defined_upicon').on 'click', (e) ->
    $field1 = $(@).parents('li')
    $field2 = $field1.prev('li')
    $field1.addClass('highlight')
    swap_fields $field1, $field2, () ->
      $field1.removeClass('highlight').insertBefore($field2)

  $('.field_list .w_defined_downicon').on 'click', (e) ->
    $field1 = $(@).parents('li')
    $field2 = $field1.next('li')
    $field1.addClass('highlight')
    swap_fields $field2, $field1, () ->
      $field1.removeClass('highlight').insertAfter($field2)

  $('#user_data_form_2').submit () ->
    if $('.show_list li').size() == 0
      alert('至少需要显示一个字段')
      return false
