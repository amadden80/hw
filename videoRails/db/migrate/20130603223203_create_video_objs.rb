class CreateVideoObjs < ActiveRecord::Migration
  def change
    create_table :video_objs do |t|
      t.string :name
      t.text :description
      t.text :url
      t.string :genre

      t.timestamps
    end
  end
end
