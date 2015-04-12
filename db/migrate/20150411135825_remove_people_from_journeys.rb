class RemovePeopleFromJourneys < ActiveRecord::Migration
  def change
  	remove_column :journeys,:people
  end
end
