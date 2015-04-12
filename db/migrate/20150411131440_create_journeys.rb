class CreateJourneys < ActiveRecord::Migration
  def change
    create_table :journeys do |t|
      t.string :from
      t.string :to
      t.integer :budget
      t.string :by
      t.integer :people
      t.string :name

      t.timestamps null: false
    end
  end
end
