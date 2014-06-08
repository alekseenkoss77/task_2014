class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :meeting
 
  # validations for meeting_spec.rb with strict: AcitveRecord::RecordNotUnique
  validates :user_id, uniqueness: {scope: :meeting_id, message: 'Should be once per meeting'},
  			strict: ActiveRecord::RecordNotUnique
end