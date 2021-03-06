class User < ActiveRecord::Base
    attr_accessor :remember_token
    before_save {self.email = email.downcase}
    
    VALIDATE_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :name, presence: true, length:{maximum:50}
    validates :email, presence: true, length:{maximum:255},
                      format: {with: VALIDATE_EMAIL_REGEX},
                      uniqueness: {case_sensitive: false}
    
    has_secure_password  
    validates :password, length:{minimum: 6}
    
    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? 
      BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
    
    # generates a new random token 
    def User.token
      SecureRandom.urlsafe_base64
    end
    
    def remember 
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User_digest(remember_token))
    end
    # return true if remember token matches digest
    def authenticated?(remember_token)
      return false if remember_digest.nil?
      BCrypt::Password.new(:remember_digest) == remember_token          
    end
end
