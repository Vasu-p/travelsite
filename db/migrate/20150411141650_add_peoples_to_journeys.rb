class AddPeoplesToJourneys < ActiveRecord::Migration
  def change
  	add_column :journeys,:peoples,:integer


  end
end
