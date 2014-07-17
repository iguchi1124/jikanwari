class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.date :deadline
      t.text :content
      t.integer :contributor_id

      t.timestamps
    end
  end
end
