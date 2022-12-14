class CreateDomains < ActiveRecord::Migration[7.0]
  def change
    create_table :domains do |t|
      t.references :institution, null: false, foreign_key: true
      t.string :domain, null: false

      t.timestamps null: false
    end
  end
end
