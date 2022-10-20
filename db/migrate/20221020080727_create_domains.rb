class CreateDomains < ActiveRecord::Migration[7.0]
  def change
    create_table :domains do |t|
      t.string :domain, null: false
      t.references :institution, null: false

      t.timestamps
    end
  end
end
