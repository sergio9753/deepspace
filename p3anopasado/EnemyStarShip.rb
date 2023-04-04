#encoding:utf-8
require_relative "ShotResult.rb"
require_relative "EnemyToUI"
module Deepspace
	class EnemyStarShip
		def initialize(n,a,s,l,d)
			@ammoPower=a
			@name=n
			@shieldPower=s
			@loot=l
			@damage=d
		end
		
		def self.newCopy(e)
			EnemyStarShip.new(e.name, e.ammoPower, e.shieldPower, e.loot, e.damage)
		end
		
		def getUIversion()
			EnemyToUI.new(self)
		end
		
		def fire()
			@ammoPower
		end
		
		attr_reader :ammoPower, :name, :shieldPower, :loot, :damage
		
		def protection()
			@shieldPower
		end
		
		def receiveShot(shot)
			if shot>@shieldPower 
				result=ShotResult::DONOTRESIST
				
			else 
				result=ShotResult::RESIST
			end
		end

		def to_s()
            getUIversion().to_s
        end 
	end
end

