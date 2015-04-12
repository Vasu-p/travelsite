class Journey < ActiveRecord::Base
	has_many :costs
	belongs_to :trip

	validates :from,:to,:budget,:peoples,:presence=>:true
end
