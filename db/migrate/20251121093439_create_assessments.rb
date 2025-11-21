class CreateAssessments < ActiveRecord::Migration[8.0]
  def change
    create_table :assessments do |t|
      t.references :candidate, null: false, foreign_key: true
      t.integer :total_questions
      t.integer :score
      t.boolean :passed
      t.string :status

      t.timestamps
    end
  end
end
