#encoding:utf-8
require_relative 'HangarToUI'
require_relative 'ShieldBooster'
require_relative 'Weapon'

module Deepspace 
    class Hangar
        def initialize(_maxElements)
			@maxElements=_maxElements
            @shieldBoosters = []  
            @weapons = []
            
		end

        def self.newCopy(h)
		    out = Hangar.new(h.maxElements)
            h.shieldBoosters().each {|x| out.addShieldBooster(x)}
            h.weapons().each {|x| out.addWeapon(x)}
            return out
		end

        def getUIversion()
			return Deepspace::HangarToUI.new(self)
		end	

        def spaceAvailable()
            return @shieldBoosters.length + @weapons.length < @maxElements
        end 

        def addWeapon(w)
            if(self.spaceAvailable())
                @weapons.push(w)
                return true
            else 
                return false
            end 
        end 

        def addShieldBooster(w)
            if(self.spaceAvailable())
                @shieldBoosters.push(w)
                return true
            else 
                return false
            end 
        end

        def maxElements()
			@maxElements
		end

        def shieldBoosters()
            @shieldBoosters
        end

        def weapons()
            @weapons
        end

        def removeShieldBooster(s)
            if ( @shieldBoosters[s] != nil)
                aux = @shieldBoosters[s]
                @shieldBoosters.delete_at(s)
                return aux
            else 
                return nil
            end
        end 

        def removeWeapon(w)
            if (@weapons[w] != nil)
                aux = @weapons[w]
                @weapons.delete_at(w)
                return aux
            else 
                return nil
            end
        end 

        def to_s()
            getUIversion().to_s
        end 
    end    
end 

