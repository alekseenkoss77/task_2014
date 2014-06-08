class User < ActiveRecord::Base
  include Searchable
  include Filterable
  
  MALE = 1
  FEMALE = 0
	 
  authenticates_with_sorcery! 
  
  before_validation { self.email = email.downcase }
  
  validates :name, presence: true
  validates :password, 
            length: { minimum: 6 }, 
            confirmation: true
  validates :password_confirmation, 
            presence: true

  validates :email, presence: true, uniqueness: true

end
