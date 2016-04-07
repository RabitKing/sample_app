class User < ActiveRecord::Base
    before_save {self.email = email.downcase}
    
    VALIDATE_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :name, presence: true, length:{maximum:50}
    validates :email, presence: true, length:{maximum:255},
                      format: {with: VALIDATE_EMAIL_REGEX},
                      uniqueness: {case_sensitive: false}
    
    has_secure_password  
    validates :password, length:{minimum: 6}
    
    def User.digest(string)
        # returns the hash digest of a given string
        cost = ActiveModel::SecurePassword.min_cost ?
        BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
end
