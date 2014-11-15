class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :date_submitted
      t.string :filepath

      t.timestamps
    end
  end
end
