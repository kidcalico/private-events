class CreateInvites < ActiveRecord::Migration[8.1]
  def change
    create_table :invites do |t|
      t.references :attended_event, null: false, foreign_key: true
      t.references :attendee, null: false, foreign_key: true
      t.boolean :rsvp

      t.timestamps
    end
  end
end
