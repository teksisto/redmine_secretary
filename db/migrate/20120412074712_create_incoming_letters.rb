class CreateIncomingLetters < ActiveRecord::Migration
  def self.up
    create_table :incoming_letters do |t|
      t.string    :code
      t.string    :outgoing_code
      t.text      :description      
      t.string    :signer
      t.string    :recipient      
      t.date      :shipping_on
      t.string    :shipping_type
      t.string    :shipping_place      
      t.boolean   :original_required
      t.integer   :user_id
      t.integer   :author_id
      t.datetime  :created_on
    end
  end

  def self.down
    drop_table :incoming_letters
  end
end
