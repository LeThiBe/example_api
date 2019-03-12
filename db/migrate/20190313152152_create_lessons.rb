class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.string :name
      t.integer :number_questions
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
