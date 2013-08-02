class Response < ActiveRecord::Base
  attr_accessible :user_id, :answer_id

  belongs_to :answer, :class_name => "Answer", :foreign_key => :answer_id, :primary_key => :id

  has_one :question, :through => :answer, :source => :question

  after_destroy :log_destroy_action

  validates :user_id, :presence => true
  validates :answer_id, :presence => true

  def log_destroy_action
      puts "Response #{id} destroyed"
  end

end
