class Question < ActiveRecord::Base
  attr_accessible :poll_id, :body

  belongs_to :poll, :class_name => "Poll", :foreign_key => :poll_id, :primary_key => :id
end
