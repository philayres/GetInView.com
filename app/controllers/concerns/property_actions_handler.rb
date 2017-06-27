module PropertyActionsHandler
  
  extend ActiveSupport::Concern
  included do
    before_action :set_object, only: [:show, :edit, :update, :destroy]
   
   before_action :set_parent_object
   #, only: [:show, :edit, :update, :destroy]
   
   before_action :set_property
  #  before_action :prep_create, only: [:edit, :new, :update, :create]
  
  end
  
  module ClassMethods
  end

  def index
    self.current_objects = parent_object.send(current_objects_var_name).all
  end
  
  def new
    self.current_object = current_class.new
    prep_object
  end


  def edit
    prep_object
  end
  
  def create
    self.current_object = current_class.new(cleaned_params)
    prep_object
    
    respond_to do |format|
      if current_object.save
        format.html { 
          red = parent_object || @property
          red = url_for(controller: controller_name, action: :index, property_id: @property.id) if index_after?(:create)
          redirect_to red, notice: "#{type_title} was successfully created." 
        }
        format.json { render :show, status: :created, location: self.current_object }
      else
        format.html { render :new }
        format.json { render json: self.current_object.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if self.current_object.update(cleaned_params)
        
        format.html { 
          red = parent_object || @property
          red = url_for(controller: controller_name, action: :index, property_id: @property.id) if index_after?(:update)
      
          redirect_to red, notice: "#{type_title} was successfully updated." }
        format.json { render :show, status: :ok, location: self.current_object }
      else
        format.html { render :edit }
        format.json { render json: self.current_object.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    not_authorized unless current_user.is_admin?
    self.current_object.destroy
    respond_to do |format|
      format.html { redirect_to property_addresses_url, notice: "#{type_title} was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
protected

  
  

private

  

  def cleaned_params
    params.require(current_object_symbol).permit(list_permitted_params)
  end
  
  def set_object
    self.current_object = current_class.find(params[:id])
    set_parent_object
  end
  
  def set_parent_object
    if parent_type != Property
    
      id = nil
      if self.current_object
        id = self.current_object[parent_object_id_symbol]
      end
      if id
      elsif params[current_object_symbol]
        id = cleaned_params[parent_object_id_symbol] || params[parent_object_id_symbol]
      else
        id = params[parent_object_id_symbol]
      end 
      
      o = parent_type.find(id)
      self.parent_object = o
      @parent_object = o
    end
  end
  
  def set_property
    
    if current_object && current_object.property_id
      id = current_object.property_id
    elsif parent_object && parent_object.property_id
      id = parent_object.property_id
    elsif params[current_object_symbol]
      id = cleaned_params[:property_id] || params[:property_id]
    else
      id = params[:property_id]
    end 
    
    if id.blank? || id == 'select:property_id'
    
      if my_properties.length == 1
        id = my_properties.first.id
      else
        logger.warn "user redirected to select property for id: #{id}"
        flash[:notice] = "Select your property before continuing"
        redirect_to properties_path(url_redirect_path_hash(:property_id).merge(mode: 'select'))
        return
      end
       
    end
    
    @property = current_user.properties.find(id)
    
    redirect_to properties_path unless @property
  end
  
  def my_properties
    current_user.properties
  end
  
  def prep_object
      self.current_object.property = @property
      self.current_object.user = current_user
      if parent_object
        self.current_object[parent_object_id_symbol] = parent_object.id
      end
      unless current_object.id?
        @create_in_property = @property
        @create_in_parent = parent_object
      end
      

  end

  
    

end