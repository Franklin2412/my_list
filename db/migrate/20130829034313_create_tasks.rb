class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :task_name
      t.boolean :complete

      t.timestamps
    end
  end
end
