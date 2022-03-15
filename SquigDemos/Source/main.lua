-- Squigsplorer
--  Play around with squigs
--
--  Scott Lawrence - yorgle@gmail.com


-- version history
local app_version = "1.2 2022-03-15"


-------------------------------------------------
-- standard stuffs
import "globals"


local cursor;

local squig_mode = 'TrioPcntSquig';

-- myGameSetUp()
--  general init stuff
function myGameSetUp()
    
    playdate.startAccelerometer()

    gfx.setColor(gfx.kColorBlack)
    textfont = playdate.graphics.font.new( "assets/diamond_12" )
    playdate.graphics.setFont( textfont )

    -- cursor
    cursor = Cursor()
    cursor:setStyle( 'arrow' )

    -- callback for rendering the background
    gfx.sprite.setBackgroundDrawingCallback(
        function( x, y, width, height )
            gfx.setClipRect( x, y, width, height ) -- let's only draw the part of the screen that's dirty

            -- draw the text
            gfx.drawText(   "Sqigsplorer - yorgle@gmail.com  v" .. app_version,
                            1,  displayH - 12 )

            gfx.clearClipRect() -- clear so we don't interfere with drawing that comes after this
        end
    )
end


function playdate.AButtonDown()
    if( squig_mode == 'AutoSquig') then
        squig_mode = 'TrioSquig'
    elseif( squig_mode == 'TrioSquig') then
        squig_mode = 'TrioPcntSquig'
    elseif( squig_mode == 'TrioPcntSquig') then
        squig_mode = 'AutoSquig'
    end

    cursor:setStyle( 'ecks' )
end

function playdate.AButtonUp()
end

local vh_toggle = false
function playdate.BButtonDown()
    vh_toggle = true
end

function playdate.BButtonUp()
    vh_toggle = false
end




-- update
--  the standard draw update routine
function playdate.update()
    playdate.timer.updateTimers()
    gfx.sprite.update()

	-- draw the name
    gfx.setColor(gfx.kColorBlack)
    gfx.drawText( squig_mode, 1,  1 )

	gfx.drawText( "dpad: Move P2\nA: next Squig Type", 1,25 )

	if( squig_mode == "AutoSqig" ) then

		gfx.drawText( "\n\nCenter is a 50% between P1,P2, swap unaffected", 1, 51 )

	elseif( squig_mode == "TrioSquig" ) then
		gfx.drawText( "B: Swap endpoints\nAccelerometer: move center\n\nCenter can be anywhere", 1, 51 )

	elseif( squig_mode == "TrioPcntSquig" ) then
		gfx.drawText( "B: Swap endpoints\n\nCenter is a specified % between P1,P2", 1, 51 )
	end
	

    local x1 = 84
    local y1 = 180
    local x2 = cursor.posx
    local y2 = cursor.posy

	-- swap endpoints
    if vh_toggle then
        x1,y1, x2,y2 = x2,y2, x1,y1
    end

	-- pull the accelerometer for a manual center
    local x,y,z = playdate.readAccelerometer()
    local xC = (x/2 + .5 )* displayW
    local yC = (y/2+.5)*displayH
    --xC = math.clamp( x1, x2, xC );
    --yC = math.clamp( y1, y2, yC );

    -- draw the right squig
    gfx.setColor(gfx.kColorBlack)
    gfx.setLineWidth( 2 )
    
    if( squig_mode == 'AutoSquig') then
        xC, yC= Squig.drawAutoSquig( x1,y1,  x2,y2 )
    elseif( squig_mode == 'TrioSquig' ) then
        Squig.drawTrioSquig( x1, y1, xC, yC, x2, y2 )
    elseif( squig_mode == 'TrioPcntSquig' ) then
        xC, yC = Squig.drawTrioPercentSquig( x1, y1, .25, .60, x2, y2 )
    end

    -- midpoint crosshair
    gfx.setLineWidth( 1 )
    gfx.setPattern( { 0xaa, 0x55, 0xaa, 0x55, 0xaa, 0x55, 0xaa, 0x55 } )
    LlamaGfx.drawCrosshairs( xC, yC )
end



-- make sure it gets run!
myGameSetUp()
