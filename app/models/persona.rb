class Persona < ActiveRecord::Base
  attr_accessible :image                                 
  has_and_belongs_to_many :categories, :order => :name
  
  mount_uploader :image, ImageUploader
end
