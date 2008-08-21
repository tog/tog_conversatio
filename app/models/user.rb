class User < ActiveRecord::Base
  has_many :bloggerships, :class_name => "Conversatio::Bloggership", :dependent => :destroy
  has_many :blogs, :class_name => "Conversatio::Blog", :through => :bloggerships
end