class Question < ActiveRecord::Base
  attr_accessible :poll_id, :body

  belongs_to :poll, :class_name => "Poll", :foreign_key => :poll_id, :primary_key => :id

  has_many :answers, :class_name => "Answer", :foreign_key => :question_id, :primary_key => :id

  def results
    results = {}
    answers = self.answers.includes(:responses)
    answers.each { |answer| results[answer.body] = answer.responses.length }
    results
  end
end
