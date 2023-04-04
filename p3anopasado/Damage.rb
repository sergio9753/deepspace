#encoding:utf-8
require_relative 'DamageToUI'
require_relative 'Weapon'
module Deepspace
	class Damage
		@@not_used=-1
		def initialize(w,wl,s)
			@nWeapons=w
			@nShields=s
			@weapons=wl
		end 
		
		def self.newNumericWeapons(w,s)
			new(w,nil,s)
		end
		
		def self.newSpecificWeapons(wl,s)
			new(@@not_used, wl,s)
		end
		
		def newCopy(d)
			if d.weapons=nil
				Damage.newNumericWeapons(d.nWeapons, d.nShields)
			else
				Damage.newSpecificWeapons(d.weapons, d.nShields)
			end
		end
		
		attr_reader:nShields, :nWeapons, :weapons
		
		def getUIversion()
			Deepspace::DamageToUI.new(self)
		end
		
		def arrayContainsType(w,t)
			i = 0
			w.each do |aux|
			  if aux.type == t
				return i
			  else
				i += 1
			  end
			end
			
			return -1
			
		end 
		
		def adjust(w,s)
			
			
			if @nShields>s.count
				n_shields=s.count
			else 
				n_shields=@nShields
			end
			
			if @weapons==nil
				if @nWeapons>w.count
					n_weapons=w.count
				else	
					n_weapons=@nWeapons
				end
				
				object= Damage.newNumericWeapons(n_weapons, n_shields)
			else
				result=[]
				w_aux=w.clone
				@weapons.each do |x| 	
					index=arrayContainsType(w_aux,x);
					if index!=@@not_used
						result << x
						w_aux.delete_at(index)
					end
				
				end
				object=Damage.newSpecificWeapons(result, n_shields)
			end
		end
		
		def discardWeapon(w)
			if @weapons==nil 
				if @nWeapons>0
					@nWeapons=@nWeapons-1
				end
			else 
				@weapons.delete_at(weapons.index(w.type))
			end		
		end
		
		def discardShieldBooster()
			if @nShields>0
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

		def to_s()
            getUIversion().to_s
        end 
			
	end
end

