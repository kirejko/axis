# Articles migration
class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.references :user,   foreign_key: true
      t.string     :title,  null: false, default: ''
      t.text       :body,   null: false, default: ''

      t.timestamps
    end
  end
end
