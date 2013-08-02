class User < ActiveRecord::Base
  attr_accessible :name, :team_id

  has_many :polls, :class_name => "Poll", :foreign_key => :user_id, :primary_key => :id

  belongs_to :team, :class_name => "Team", :foreign_key => :team_id, :primary_key => :id

  def take_poll
    available_polls = team.polls.where("user_id != ?", id)
    alphabet = PollRunner::ALPHABET
    available_polls.each_with_index do |poll, index|
      puts "#{alphabet[index]}. Poll #{poll.id}"
    end
    letter_choice = gets.chomp
    poll_choice = available_polls[alphabet.index(letter_choice)]
    poll_choice.run(self)
  end

  def answered_question?(question)
    Response.where("user_id = ?", id).includes(:question).map do |response|
      response.question.id
    end.include?(question.id)
  end

  def get_responses
    Response.find_all_by_user_id(id)
  end

  def get_polls
    Poll.find_all_by_user_id(id)
  end

end
