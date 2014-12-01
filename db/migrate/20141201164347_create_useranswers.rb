class CreateUseranswers < ActiveRecord::Migration
  def change
    create_table :useranswers do |t|
      t.integer :user_id
      t.integer :exercise_id
      t.boolean :status
      t.string :answer
      t.timestamps
    end
    add_index :useranswers, :user_id
    add_index :useranswers, :exercise_id
  end
end
