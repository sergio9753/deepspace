#encoding:utf-8
module Deepspace
require_relative "ShieldToUI"
	class ShieldBooster
		def initialize(_name, _boost, _uses)
			@name=_name
			@boost=_boost
			@uses=_uses
		end
		
		def self.newCopy(s)
			ShieldBooster.new(s.name, s.boost, s.uses)
		end
		
		def getUIversion()
			return Deepspace::ShieldToUI.new(self)
		end
		
		def name()
			@name
		end
		
		def boost()
			@boost
		end
		
		def uses()
			@uses
		end
		
		def useIt()
			if @uses>0
				@uses=@uses-1
				@boost
			else
				return 1.0	
			end
		end

		def to_s()
            getUIversion().to_s
        end 
	end
end


