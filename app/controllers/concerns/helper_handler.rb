module HelperHandler

  extend ActiveSupport::Concern
  
  protected

  def url_redirect_path_hash exclude_param=nil, path=nil
    p = path || request.path
    par = params.except(:action).except(:controller).except(:redpath).except(exclude_param)
    
    uri = "#{p}?#{par.to_hash.to_query}"
    u = Base64.urlsafe_encode64(uri)
    { redpath: u }
  end
  
  def redirect_redpath pextra={}
    p = params[:redpath]
    return if p.blank?
    u = Base64.urlsafe_decode64(p)
    pgot=nil
    pextra.each do |a,b|
      if u.include?("select:#{a.to_s}")
        u.gsub!("select:#{a.to_s}", b.to_s)
        pgot = a
        break
      end
    end
    pextra = pextra.except(pgot)  if pgot
    "#{u}&#{pextra.to_query}"
  end
  
  

  def current_object_var_name
    controller_name.singularize
  end
  
  def current_objects_var_name
    controller_name
  end
  
  def current_object_symbol
    current_object_var_name.to_sym
  end 
  
  def current_class
    n = self.class.name || controller.class.name
    name = n.gsub('Controller', "").singularize
    name.constantize
  end
  
  def current_object
    name = '@' + current_object_var_name
    instance_variable_get(name)
  end

  def current_object= value
    name = '@' + current_object_var_name
    instance_variable_set(name, value)
  end
  
  def current_objects
    name = '@' + current_objects_var_name
    instance_variable_get(name)
  end

  def current_objects= value
    name = '@' + current_objects_var_name
    instance_variable_set(name, value)
  end
  
  def parent_object_var_name
    parent_type.name.underscore
  end
  
   def parent_object_symbol
    parent_object_var_name.to_sym
  end
  
  def parent_object_id_symbol
    "#{parent_object_var_name}_id".to_sym
  end
  
  
  def parent_object
    name = '@' + parent_object_var_name
    instance_variable_get(name)
  end
  
  def parent_object= value
    name = '@' + parent_object_var_name
    instance_variable_set(name, value)
  end
  
  def parent_type
    current_class.parent_type
  end
  
  def type_title 
    controller_name.titleize
  end
  
  def types_title 
    controller_name.pluralize.titleize
  end
  
end