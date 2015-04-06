class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
    	t.date :pub_date
    	t.text :section_name
    	t.string :web_url
    	t.text :headline
    	t.text :lead_paragraph

      t.timestamps null: false
    end
  end
end
