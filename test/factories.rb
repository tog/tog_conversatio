Factory.sequence :login do |n|
  "person#{n}"
end

Factory.sequence :email do |n|
  "person#{n}@example.com"
end

Factory.sequence :title do |n|
  "title#{n}"
end

Factory.define :user do |u|
  u.login { random_string }
  u.salt '7e3041ebc2fc05a40c60028e2c4901a81035d3cd'
  u.crypted_password '00742970dc9e6319f8019fd54864d3ea740f04b1'
  u.activation_code '8f24789ae988411ccf33ab0c30fe9106fab32e9a'
  u.state 'pending'
  u.email { random_email_address }
end

def random_string
  letters = *'a'..'z'
  random_string_for_uniqueness = ''
  10.times { random_string_for_uniqueness += letters[rand(letters.size - 1)]}
  random_string_for_uniqueness
end

def random_email_address
  "#{random_string}@example.com"
end

Factory.define :blog do |b|
  b.title { |a| Factory.next :title }
  b.association :author, :factory => :user
end

Factory.define :bloggership do |u|
end

Factory.define :post do |p|
  p.title { |a| Factory.next :title }  
  p.association :blog, :factory => :blog
  p.association :user, :factory => :user
end