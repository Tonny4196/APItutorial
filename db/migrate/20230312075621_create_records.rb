class CreateRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :records do |t|
      t.string :title
      t.decimal :study_hour

      t.timestamps
    end
  end
end
