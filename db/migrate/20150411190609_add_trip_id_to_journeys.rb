class AddTripIdToJourneys < ActiveRecord::Migration
  def change
  	add_column :journeys,:trip_id,:integer
  end
end
