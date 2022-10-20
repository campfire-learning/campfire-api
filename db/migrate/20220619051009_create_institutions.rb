class CreateInstitutions < ActiveRecord::Migration[7.0]
  def change
    create_table :institutions do |t|
      t.string  :name
      t.integer :institution_type
      t.string  :url
      t.string  :country
      t.text    :domains, default: '', array: true
      t.string  :address

      t.timestamps
    end
  end
end
