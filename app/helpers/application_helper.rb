#encoding: utf-8
module ApplicationHelper
  # render json for select2,index and show included
  #
  # render_select2 object, extra_attr1, extra_attr2, id: id_method, text: name_method
  #   
  #   respond_to do |format|
  #     format.html
  #     format.json { render_select2 @city, text: 'city_name' }
  #   end

  def render_select2(*args)
    render json: data_select2(*args)
  end

  def data_select2(*args)
    options=args.extract_options!
    name_method = options.fetch(:text, :to_s)
    id_method   = options.fetch(:id, :id)
    object=args.shift
    if object.respond_to? :map
      {
        results: object.map do |o|
          {id: o.send(id_method), text: o.send(name_method)}
          .merge Hash[args.zip args.map{|x| o.send x}]
        end,
        total: object.total_count
      }
    else
      {id: object.send(id_method), text: object.send(name_method)}
      .merge(Hash[args.zip args.map{|x| object.send x}])
    end
  end

  def active href
    :active if href.start_with?("/#{params[:controller]}")
  end
end
