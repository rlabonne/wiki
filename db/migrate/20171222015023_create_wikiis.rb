class CreateWikiis < ActiveRecord::Migration[5.1]
  def change
    create_table :wikiis do |t|
      t.string :title
      t.text :body
      t.boolean :private
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
