$.extend $.fn.select2.defaults,
  formatNoMatches: () -> "没有找到匹配的项"
  formatInputTooShort: (input, min) -> "请再输入#{min - input.length}个字符"
  formatInputTooLong: (input, max) -> "请删除#{input.length - max}个字符"
  formatSelectionTooBig: (limit) -> "最多选择#{limit}项"
  formatLoadMore: (pageNumber) -> "正在加载..."
  formatSearching: () -> "正在查找..."

# 初始化所有 select2 控件
# select 会被渲染为 select2 控件，如果需要搜索功能，可以加上 data-searchable="1" 属性
$.fn.extend
  lazy_select2: (options) ->
    options = $.extend { page_size: 15 }, options
    @select2
      allowClear: true
      placeholder: options.placeholder || '请选择'
      width: 222
      multiple: options.multiple || false
      initSelection: (element, callback) ->
        id = element.val()
        if id != '' and id != null
          $.ajax
            url: options.init(id)
            dataType: 'json'
            success: (data) ->
              callback(data)
      ajax:
        url: options.url
        dataType: 'json'
        quietMillis: 100
        data: (term, page) ->
          options.params(term, page)
        results: (data, page) ->
          more = (page * options.page_size) < data.total
          return {} =
            results: data.results
            more: more
  lazy_select2_driver: (options) ->
    options = $.extend { page_size: 15 }, options
    @select2
      allowClear: true
      placeholder: options.placeholder || '请选择'
      formatResult:(item)-> item.text+"|"+item.driver_phone+"|"+item.driver_allowed
      width: 222
      multiple: options.multiple || false
      initSelection: (element, callback) ->
        id = element.val()
        if id != '' and id != null
          $.ajax
            url: options.init(id)
            dataType: 'json'
            success: (data) ->
              callback(data)
      ajax:
        url: options.url
        dataType: 'json'
        quietMillis: 100
        data: (term, page) ->
          options.params(term, page)
        results: (data, page) ->
          more = (page * options.page_size) < data.total
          return {} =
            results: data.results
            more: more
  lazy_select2_car: (options) ->
    options = $.extend { page_size: 15 }, options
    @select2
      allowClear: true
      placeholder: options.placeholder || '请选择'
      formatResult:(item)-> item.text+"|"+item.car_model_name
      width: 222
      multiple: options.multiple || false
      initSelection: (element, callback) ->
        id = element.val()
        if id != '' and id != null
          $.ajax
            url: options.init(id)
            dataType: 'json'
            success: (data) ->
              callback(data)
      ajax:
        url: options.url
        dataType: 'json'
        quietMillis: 100
        data: (term, page) ->
          options.params(term, page)
        results: (data, page) ->
          more = (page * options.page_size) < data.total
          return {} =
            results: data.results
            more: more
  car_type_select2: ->
    @lazy_select2
      url: -> '/car_types'
      init: (id) -> '/car_types/' + id
      params: (term, page) ->
        return {}=
          search: {
            car_type_name_contains: term
          }
          page: page
  pickup_city_select2: () ->
    @lazy_select2
      url: -> '/cities'
      init: (id) -> '/cities/' + id
      params: (term, page) ->
        return {}=
          search: {
            city_name_contains: term
          }
          page: page
  pickup_district_select2: () ->
    @lazy_select2
      url: -> '/districts'
      init: (id) -> '/districts/' + id
      params: (term, page) ->
        return {}=
          search: {
            city_id_equals: $('#pickup_city').val()
            district_name_contains: term
          }
          page: page
  location_select2: () ->
    @lazy_select2
      url: -> '/locations'
      init: (id) -> '/locations/' + id
      params: (term, page) ->
        return {}=
          search: {
            city_id_equals: $('#pickup_city').val()
            company_id_equals: $('#company_id').val()
            district_id_equals: $('#pickup_district').val()
            location_name_contains: term
            status_equals: 1
          }
          page: page
  car_model_api_select2: () ->
    @lazy_select2
      url: -> '/dispatch_car_model'
      init: (id) -> '/dispatch_car_model/' + id
      params: (term, page) ->
        return {}=
          search: {
            city_id_equals: $('#pickup_city').val()
            company_id_equals: $('#company_id').val()
            district_id_equals: $('#pickup_district').val()
            location_name_contains: term
            status_equals: 1
          }
          page: page

  car_info_select2: () ->
    @lazy_select2_car
      url: -> '/cars'
      init: (id) -> '/cars/' + id
      params: (term, page) ->
        return {}=
          search: {
            location_id_equals: $('#location_id').val()
            status_equals:'enable'
            car_tag_contains: term
            #car_type_id_equals: $("#reservation_car_type_id").val()
            #seat_equals:$('#reservation_seat').val()
          }
          page: page
  driver_info_select2: () ->
    @lazy_select2_driver
      url: -> '/drivers'
      init: (id) -> '/drivers/' + id
      params: (term, page) ->
        return {}=
          search: {
            location_id_equals: $('#location_id').val()
            status_equals: 'enable'
            driver_name_contains: term
            #driver_allowed_contains: $('#reservation_seat').val()
          }
          page: page
  company_info_select2: () ->
    @lazy_select2
      url: -> '/companies'
      init: (id) -> '/companies/' + id
      params: (term, page) ->
        return {}=
          search: {
            company_name_contains: term
            status_equals: 0
          }
          page: page

  car_model_select2: (multiple=true) ->
    @lazy_select2
      multiple: multiple
      url: -> '/car_models'
      init: (id) -> '/car_models/' + id
      params: (term, page) ->
        return {}=
          search: {
            car_model_name_contains: term
          }
          page: page
  init_components: () ->
    @find('select:not(.select2)').select2 allowClear: true
    $('#pickup_city,#return_city').pickup_city_select2()
    $('#pickup_district,#return_district').pickup_district_select2()
    $('#location_id,#drivers__location_id').location_select2()
    $('#car_id').car_info_select2()
    $('#driver_id').driver_info_select2()
    $('#company_id,#drivers__company_id').company_info_select2()

    $('#car_model_ids').car_model_select2()
    $('#self_drive_price_car_model_id').car_model_select2(false)
    $('#self_drive_price_location_id').location_select2()
    $('#search_car_model_id_equals').car_model_select2(false)
    $('#search_location_id_equals').location_select2()

    $('.car_type_select').car_type_select2()
