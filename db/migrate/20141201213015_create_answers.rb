class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :user_id
      t.integer :exercise_id
      t.text :answer, limit: nil
      t.json :specson
      t.text :spectml, limit: nil
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
