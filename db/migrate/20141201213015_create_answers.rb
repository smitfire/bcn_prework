class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :user_id
      t.integer :exercise_id
      t.string :answer
      t.json :specson
      t.json :spectml
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
