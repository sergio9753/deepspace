require_relative "WeaponType.rb"
require_relative "DamageToUI.rb"

module Deepspace
    class Damage
		@@not_used=-1
		def initialize(w,wl,s)
			@nWeapons=w
			@weapons=wl
			@nShields=s            
		end 

        def self.newNumericWeapons(w,s)
            new(w,nil,s)
        end 

        def self.newSpecificWeapons(wl,s)
            new(@@not_used,wl,s)
        end 

        def self.newCopy(d)
            if d.weapons = nil
                Damage.newNumericWeapons(d.nWeapons,d.nShields)
            else
                Damage.newSpecificWeapons(d.weapons,d.nShields)
            end 
        end    

        attr_reader:nShields, :nWeapons, :weapons

        def getUIversion()
			Deepspace::DamageToUI.new(self)
        end 

        def arrayContainsType(w,t)
            out = -1
            i = 0
            w.each do |weapon|
                if weapon.type = t 
                    out = i
                end 
                i++
            end
            return out
        end 

        def adjust(w,s)

        end 

        def discardWeapon(w)

        end 

        def discardShieldBooster()
            if (@nShields-1 >= 0)
                @nShields=@nShields-1
            end 
        end    

        def hasNoEffect()
            if @weapons != nil
				return @weapons.empty? && @nShields == 0
			  else
				return @nShields + @nWeapons == 0
            end
        end     
    end 
end