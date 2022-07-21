class CreateKlassMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :klass_memberships do |t|
      t.references :klass, null: false
      t.references :user, null: false
      t.integer :role, null: false

      t.timestamps
    end
  end
end
