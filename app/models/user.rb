class User < ActiveRecord::Base
    has_many :games, dependent: :destroy
    
    has_secure_password

    validates_uniqueness_of :email
end