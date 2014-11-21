class AddColumnToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :user_id, :integer
    add_column :videos, :question_id, :integer
    add_column :videos, :the_answer, :string
  end
end
