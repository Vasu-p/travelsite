class AddJourneyIdToCosts < ActiveRecord::Migration
  def change
  	add_column :costs,:journey_id,:integer
  end
end
