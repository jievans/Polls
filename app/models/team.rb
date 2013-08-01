class Team < ActiveRecord::Base
  attr_accessible :name

  has_many :users, :class_name => "User", :foreign_key => :team_id, :primary_key => :id

  has_many :polls, :through => :users, :source => :polls
end
