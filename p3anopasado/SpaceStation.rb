#encoding:utf-8
require_relative 'SpaceStationToUI'

module Deepspace 
    class SpaceStation



        def initialize(n, supplies)
		@MAXFUEL = 100 
		@SHIELDLOSSPERUNITSHOT = 0.1     
		@name=n
		@nMedals = 0
		    
		@hangar = nil
		@pendingDamage = nil
		@shieldBoosters = []  
		@weapons = [] 
		@ammoPower= supplies.ammoPower
		@shieldPower= supplies.shieldPower
		@fuelUnits = supplies.fuelUnits
	        	    
	end
                    
	def assignFuelValue(f)
            @fuelUnits = f
        end

        def cleanPendingDamage()
            if (@pendingDamage.hasNoEffect())
                @pendingDamage = nil
            end 
        end

        def cleanUpMountedItems()
            @weapons.delete_if {|weapon| weapon.uses() == 0}
            @shieldBoosters.delete_if {|sb| sb.uses() == 0}
            
        end

        def discardHangar()
            @hangar = nil
        end

        def discardShieldBooster(i)
            size= @shieldBoosters.length()
            if(i>=0 && i<size)
                s=@shieldBoosters.delete_at(i)
                if(@pendingDamage!=nil)
                    @pendingDamage.discardShieldBooster()
                    cleanPendingDamage()
                end 
            end 

        end
        
        def discardShieldBoosterInHangar(i)
            if (@hangar != nil)
                @hangar.removeShieldBooster(i)
            end 
        end 

        def discardWeapon(i)
            size= @weapons.length()
            if(i>=0 && i<size)
                w=@weapons.delete_at(i)
                if(@pendingDamage!=nil)
                    @pendingDamage.discardWeapon(w)
                    cleanPendingDamage()
                end 
            end 
        end

        def discardWeaponInHangar(i)
            if (@hangar != nil)
                @hangar.removeWeapon(i)
            end 
        end 

        def fire()
            factor=1
        
            for w in @weapons do
                factor*=w.useIt()
            end
            
            return @ammoPower*factor
        end 

        def ammoPower()
            @ammoPower
        end 
        
        def fuelUnits()
            @fuelUnits 
        end

        def hangar()
            @hangar
        end 

        def name()
            @name
        end

        def nMedals()
            @nMedals
        end
        
        def pendingDamage()
            @pendingDamage
        end
        
        def shieldBoosters()
            @shieldBoosters
        end

        def shieldPower()
            @shieldPower
        end

        def speed()
            return (@fuelUnits / @MAXFUEL)
        end

        def getUIversion()
			return SpaceStationToUI.new(self)
		end	

        def weapons()
            @weapons
        end

        def mountShieldBooster(i)
            if (@hangar != nil)
                aux = @hangar.removeShieldBooster(i)
                if (aux != nil)
                    @shieldBoosters.push(aux)
                end 
            end 
        end

        def mountWeapon(i)
            if (@hangar != nil)
                aux = @hangar.removeWeapon(i)
                if (aux != nil)
                    @weapons.push(aux)
                end 
            end 
        end

        def move()
            if (@fuelUnits -  speed() >= 0)
                @fuelUnits -=  speed()
            else 
                @fuelUnits = 0
            end
            
        end

        def protection()
            factor=1
        
            for s in @shieldBoosters do
                factor*=s.useIt()
            end
            
            return @shieldPower*factor
        
        end

        def receiveHangar(h)
            if(@hangar == nil)
                @hangar = h
            end 
        end

        def receiveShieldBooster(s)
            if (@hangar != nil)
                @hangar.addShieldBooster(s)
            else 
                return false
            end 
        end

        def receiveShot(shot)
            myProtection= protection()
            if(myProtection>=shot)
                remaining=@SHIELDLOSSPERUNITSHOT*shot
                if (@shieldPower-remaining>=0)
                    @shieldPower = @shieldPower-remaining
                else 
                    @shieldPower = 0
                end                
                result= ShotResult::RESIST
            else
                result= ShotResult::DONOTRESIST
            end
            return result
        end

        def receiveSupplies(s)
            @ammoPower += s.ammoPower
            @fuelUnits += s.fuelUnits
            @shieldPower += s.shieldPower
        end

        def receiveWeapon(w)
            if (@hangar != nil)
                @hangar.addWeapon(w)
            else 
                return false
            end 
        end

        def setLoot(loot)
            dealer = CardDealer.instance()
            h = loot.nHangars()
            
            if (h>0)
                hangar=dealer.nextHangar()
                receiveHangar(hangar)
            end
            
            elements= loot.nSupplies()

            elements.times do 
                sup= dealer.nextSuppliesPackage()
                receiveSupplies(sup)
            end
            
            elements= loot.nWeapons()
            
            elements.times do 
                weap=dealer.nextWeapon()
                receiveWeapon(weap)
            end
            
            elements= loot.nShields()
            
            elements.times do 
                sh= dealer.nextShieldBooster()
                receiveShieldBooster(sh)
            end
            
            medals=loot.nMedals()
            @nMedals+=medals
        end

        def setPendingDamage(d)
            @pendingDamage = d.adjust(@weapons,@shieldBoosters)
        end

        def validState()
            return (@pendingDamage == nil || @pendingDamage.hasNoEffect())
        end

        def to_s()
            getUIversion().to_s
        end 
    end    
end 



