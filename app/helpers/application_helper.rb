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

  def parent_layout(layout)
    @view_flow.set(:layout,output_buffer)
    self.output_buffer = render(:file => "layouts/#{layout}")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end  

  def coupon_tag coupon=nil
    if coupon
      "-#{coupon.denomination}"
    else
      '无'
    end
  end 

  #未处理订单
  def order_count    
    if current_user.role=='oprator'
      @where = current_user.company.locations.pluck(:id) 
      Reservation.where("pickup_location_id in (?) ",@where).where(:status=>:waitexec).count  
    else 
      Reservation.where(:status=>:waitexec).count  
    end
  end
end
