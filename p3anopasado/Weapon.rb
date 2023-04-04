#encoding:utf-8
require_relative "WeaponType.rb"
require_relative "WeaponToUI"
module Deepspace 
	class Weapon
		def initialize(_name, _type, _uses)
			@name=_name
			@type=_type
			@uses=_uses
		end
		
		def getUIversion()
			Deepspace::WeaponToUI.new(self)
		end
		
        	def name()
			@name
		end

		def type()
			@type
		end
		
		def uses()
			@uses
		end

		def self.newCopy(w)
			Weapon.new(w.name, w.type, w.uses)
		end
		
		def power()
           		@type.power 
       	end      
        
		def useIt()
			if @uses > 0  
				@uses -= 1
				return power()
			else 
				return 1
			end         
		end

		def to_s()
            getUIversion().to_s
        end 

	end
end
