class User < ApplicationRecord

  attr_accessor :login
  # Нужно, чтобы при создании пользователя мы могли указывать его login
  
  has_one :cart    
  has_many :orders
  # !!! используется множ. число, т.к. has_many !!!

end
