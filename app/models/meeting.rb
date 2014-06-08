class Meeting < ActiveRecord::Base
  include Searchable


  date_time_attribute :started_at
  validates :started_at, presence: true 
  validates :name, presence: true

  SELECT_FIELDS = 'users.*, assignments.role as role, assignments.created_at as registered_at'
  
  has_many :assignments, dependent: :destroy
  has_many :participants, -> { select(SELECT_FIELDS) }, through: :assignments, source: :user, class_name: "User"

  has_many :presenters, -> { select(SELECT_FIELDS).where("assignments.role = 1") }, 
    through: :assignments, 
    source: :user, 
    class_name: "User"

  has_many :listeners, -> { select(SELECT_FIELDS).where("assignments.role = 0") }, 
    through: :assignments, 
    source: :user, 
    class_name: "User"
    
  # Build association
  def add_user(user, role = 0)
    self.assignments.build(user_id: user_id(user), role: role)
  end

  # Create association
  def add_user!(user, role = 0)
    self.assignments.create!(user_id: user_id(user), role: role)
  end

  private
    def user_id(user)
      user.is_a?(User) ? user.id : user
    end
end
