class User < ApplicationRecord
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :password, presence: true, confirmation: true

    attr_accessor :password_confirmation
  
  
    has_secure_password
  end
  