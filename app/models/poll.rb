class Poll < ActiveRecord::Base
  attr_accessible :user_id

  belongs_to :user, :class_name => "User", :foreign_key => :user_id, :primary_key => :id

  has_many :questions, :class_name => "Question", :foreign_key => :poll_id, :primary_key => :id

  def run(user)
    alphabet = PollRunner::ALPHABET
    questions.each do |question|
      next if user.answered_question?(question)
      puts question.body
      question_answers = question.answers
      question_answers.each_with_index do |answer, index|
        puts "#{alphabet[index]}.  #{answer.body}"
      end
      answer_letter = gets.chomp.upcase
      chosen_answer = question_answers[alphabet.index(answer_letter)]
      Response.new(:user_id => user.id, :answer_id => chosen_answer.id).save!
    end
    puts "Thanks for taking our poll!"
  end

  def print_results
    ques_w_resp = questions.includes(:answers => [:responses])
    ques_w_resp.each do |question|
      results = {}
      puts question.body
      question.answers.each { |answer| results[answer.body] = answer.responses.length }
      puts results
    end
  end
end
