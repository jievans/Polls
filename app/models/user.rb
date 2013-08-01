class User < ActiveRecord::Base
  attr_accessible :name, :team_id

  has_many :polls, :class_name => "Poll", :foreign_key => :user_id, :primary_key => :id

end
