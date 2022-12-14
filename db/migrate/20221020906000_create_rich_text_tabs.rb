class CreateRichTextTabs < ActiveRecord::Migration[7.0]
  def change
    create_table :rich_text_tabs do |t|
      t.text :content, null: false
      t.timestamps null: false
    end
  end
end
