class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.references :language, null: false, foreign_key: true
      t.text :question_text
      t.jsonb :options
      t.string :correct_answer
      t.integer :difficulty

      t.timestamps
    end
  end
end
