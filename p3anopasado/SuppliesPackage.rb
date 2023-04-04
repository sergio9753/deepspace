#encoding:utf-8
module Deepspace 
	class SuppliesPackage
		def initialize(_ammoPower, _fuelUnits, _shieldPower)
			@ammoPower=_ammoPower
			@fuelUnits=_fuelUnits
			@shieldPower=_shieldPower
		end
		
		def ammoPower()
			@ammoPower
		end
		
		def fuelUnits()
			@fuelUnits
		end
		
		def shieldPower()
			@shieldPower
		end

		def self.newCopy(s)
			
			SuppliesPackage.new(s.ammoPower, s.fuelUnits, s.shieldPower)
		end
		
		
	end
end


