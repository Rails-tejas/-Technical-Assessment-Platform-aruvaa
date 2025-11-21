class CreateCandidates < ActiveRecord::Migration[8.0]
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :email
      t.integer :score
      t.boolean :passed

      t.timestamps
    end
  end
end
