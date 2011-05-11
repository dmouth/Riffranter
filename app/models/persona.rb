class Persona < ActiveRecord::Base
  has_and_belongs_to_many :categories, :order => :name
  validates :name, :presence => true, :uniqueness => true
  validates :title, :presence => true

  mount_uploader :image, ImageUploader
end

# == Schema Information
#
# Table name: personas
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  title      :string(255)
#  image      :text
#  created_at :datetime
#  updated_at :datetime
#

