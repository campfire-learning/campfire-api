class CreatePdfTabs < ActiveRecord::Migration[7.0]
  def change
    create_table :pdf_tabs do |t|
      #actual pdf stored in active_storage
      t.timestamps null: false
    end
  end
end
