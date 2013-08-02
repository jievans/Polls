class PollRunner

  #create poll method

  ALPHABET = ("A".."Z").to_a

  def self.create_team(name)
    Team.new(:name => name).save!
  end

  def self.create_user(name, team_name)
    team = Team.find_by_name(team_name)
    @@current_user = User.new(:name => name, :team_id => team.id)
    @@current_user.save!
  end

  def self.login(name)
    @@current_user = User.find_by_name(name)
  end

  def self.create_poll
    poll = Poll.new(:user_id => @@current_user.id)
    poll.save!
    puts "Your poll id is #{poll.id}!"
  end

  def self.create_question(body, poll_id)
    question = Question.new(:poll_id => poll_id, :body => body)
    question.save!

    puts "Please enter possible answers to this question, separated by a comma."

    answers = gets.chomp.split(", ")

    answers.each do |body|
      Answer.new(:body => body, :question_id => question.id  ).save!
    end

    puts "You have created the question: #{question.body}"
    alphabet_index = ('A'..'Z').to_a
    question.answers.each_with_index do |answer, index|
      puts "#{alphabet_index[index]}: #{answer.body}"
    end
  end

  def self.take_poll
    @@current_user.take_poll()
  end

  def self.get_results(poll_id)
    Poll.find_by_id(poll_id).print_results
  end

  def self.get_polls
    @@current_user.get_polls
  end

  def self.get_responses
    @@current_user.get_responses
  end

end