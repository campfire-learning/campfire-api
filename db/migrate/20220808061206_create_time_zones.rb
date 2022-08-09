class CreateTimeZones < ActiveRecord::Migration[7.0]
  def change
    create_table :time_zones do |t|
      t.string :name, null: false
      t.string :tz_identifier, null: false
      t.integer :utc_offset, null: false

      t.timestamps
    end
  end
end
