class User < ActiveRecord::Base
    has_many :games
    
    has_secure_password

    validates_uniqueness_of :email
end