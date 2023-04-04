require_relative 'GameCharacter'

module Deepspace

    class Dice

        def initialize
            @NHANGARSPROB = 0.25
            @NSHIELDSPROB = 0.25
            @NWEAPONSPROB = 0.33
            @FIRSTSHOTPROB= 0.5
            @generator = Random.new
        end

        def initWithNHangars
            prob = @generator.rand
            if prob < @NHANGARSPROB
                0
            else
                1                
            end
        end

        def initWithNWeapons
            prob = @generator.rand
            if prob < @NWEAPONSPROB
                1
            elsif prob < 2*@NWEAPONSPROB
                2
            else
                3
            end 
        end

        def initWithNShields
            prob = @generator.rand
            if prob < @NSHIELDSPROB
                0
            else
                1
            end
        end

        def whoStarts(nPlayers)
            @generator.rand(0..nPlayers)
        end

        def firstShot
            prob = @generator.rand
            if prob < @FIRSTSHOTPROB
                GameCharacter::SPACESTATION
            else
                GameCharacter::ENEMYSTARSHIP
            end
        end

        def spaceStationMoves(speed)
            prob = @generator.rand
            if prob < speed
                true
            else
                false
            end
        end
    end
end
