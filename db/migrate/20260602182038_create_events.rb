class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string :party_title
      t.datetime :date
      t.string :location
      t.text :more_info

      t.timestamps
    end
  end
end
