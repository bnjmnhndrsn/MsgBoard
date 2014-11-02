class Vote < ActiveRecord::Base
  validates :votable, :user, presence: true
  validates :user, :uniqueness => { :scope => :votable }
  
  belongs_to :user
  belongs_to :votable, polymorphic: true
end
