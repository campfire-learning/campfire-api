class CreateInstitutions < ActiveRecord::Migration[7.0]
  def change
    create_table :institutions do |t|
      t.string :name
      t.string :institution_type
      
      #TODO - guarantee single word, lowercase
      t.string :url_slug

      t.string :home_url

      t.timestamps null: false
    end

    add_index :institutions, [:name, :institution_type], unique: true
    add_index :institutions, [:url_slug], unique: true
  end
end
