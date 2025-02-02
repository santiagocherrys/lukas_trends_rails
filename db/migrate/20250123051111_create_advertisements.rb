class CreateAdvertisements < ActiveRecord::Migration[7.2]
  def change
    create_table :advertisements do |t|
      t.string :title
      t.string :image_url
      t.string :link

      t.timestamps
    end
  end
end
