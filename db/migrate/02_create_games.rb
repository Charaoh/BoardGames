class CreateGames < ActiveRecord::Migration[5.2]
    def change
      create_table :games do |t|
        t.integer :user_id
        t.integer :game_length
        t.boolean :won
        
        t.timestamps null: false
      end
    end  
  end
  