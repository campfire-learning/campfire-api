class CreateInstitutions < ActiveRecord::Migration[7.0]
  def change
    create_table :institutions do |t|
      t.string :name
      t.string :institution_type
      t.string :url_slug
      t.string :home_url
      t.string :country

      t.timestamps
    end
  end
end
