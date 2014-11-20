class ChangeColumnOfQuestion < ActiveRecord::Migration
  def change
    rename_column :questions, :question, :the_question
  end
end
