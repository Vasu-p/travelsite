class Cost < ActiveRecord::Base
belongs_to :journey

validates :amount,:presence=>:true
validates :person,:presence=>:true
end
