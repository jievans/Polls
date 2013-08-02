class AddForeignIndices < ActiveRecord::Migration
  def change
    add_index :users, :team_id
    add_index :polls, :user_id
    add_index :questions, :poll_id
    add_index :answers, :question_id
    add_index :responses, [:user_id, :answer_id]
  end
end
