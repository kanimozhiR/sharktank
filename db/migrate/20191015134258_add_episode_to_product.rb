class AddEpisodeToProduct < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :episode, null: false, foreign_key: true
  end
end
