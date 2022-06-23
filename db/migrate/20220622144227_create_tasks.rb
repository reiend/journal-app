class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :name, null: false, default: ''
      t.string :description, null: false, default: ''
      t.datetime :deadline, null: false, default: (DateTime.now + 24.hour)
      t.datetime :date_created, default: Date.today

      t.timestamps
    end
  end
end
