class User < ActiveRecord::Base
  has_many :bloggerships, :dependent => :destroy
  has_many :blogs, :through => :bloggerships
end