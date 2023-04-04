#encoding:utf-8
require_relative "LootToUI"
module Deepspace
	class Loot
		def initialize(_nSupplies, _nWeapons, _nShields, _nHangars, _nMedals)
			@nSupplies=_nSupplies
			@nWeapons=_nWeapons
			@nShields=_nShields
			@nHangars=_nHangars
			@nMedals=_nMedals
		end
		
		def getUIversion()
			Deepspace::LootToUI.new(self)
		end

		def nSupplies()
			return @nSupplies
		end

		def nWeapons()
			return @nWeapons
		end

		def nShields()
			return @nShields
		end

		def nHangars()
			return @nHangars
		end

		def nMedals()
			return @nMedals
		end

		def to_s()
            getUIversion().to_s
        end 
	end
end


