class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable,
         :lockable, :timeoutable, :confirmable


  AdminList = ['phil.ayres@getinview.com']
  
  has_many :properties, -> { unscope(where: :id)}
  
  def self.is_admin? current_user
    return nil unless current_user
    AdminList.clone.include? current_user.email
  end
  
  def is_admin?
    self.class.is_admin? self
  end
  
  def set_is_me user
    @is_me = (user==self)
  end
  
  def is_me?
    @is_me
  end
  
end
