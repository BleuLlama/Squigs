-- Squigs!
--  spliney kind of line squiggles... sorta like the roundrect version of a spline
--
--  Scott Lawrence - yorgle@gmail.com


displayW = playdate.display.getWidth()
displayH = playdate.display.getHeight()



class('Squig').extends( Object )

function Squig:init()
    Squig.super.init( self ) 
    -- not used.
end


-- draw an auto squig
--- sorta like the roundrect version of a spline.
function Squig.drawAutoSquig( x1, y1,  x2, y2 )

    local gfx = playdate.graphics

    -- if it's backwards, swap it
    if( x1 > x2 ) then
        x1, y1, x2, y2 = x2, y2, x1, y1 
    end

    -- make the radius dependent on the squig deltas
    local dx = math.abs( x2-x1 )
    local dy = math.abs( y2-y1 )
    local radius = math.min( dy/4, dx/4 )

    if( radius > 32 ) then
        radius = 32
    end

    local r2 = radius + radius

    local xh = (x2+x1)/2
    local yh = (y2+y1)/2

    if( y1 < y2 ) then 
        -- draw for quadrants 2 and 4
        gfx.drawLine( x1, y1,  xh-radius, y1 )
        gfx.drawArc( xh-radius, y1+radius, radius, 0, 90 )
        gfx.drawLine( xh, y1+radius, xh, y2-radius )
        gfx.drawArc( xh+radius, y2-radius, radius, 180, 270 )
        gfx.drawLine( xh+radius, y2,  x2, y2 )
    else
        gfx.drawLine( x1, y1,  xh-radius, y1 )
        gfx.drawArc( xh-radius, y1-radius, radius, 90, 180 )
        gfx.drawLine( xh, y1-radius, xh, y2+radius )
        gfx.drawArc( xh+radius, y2+radius, radius, 270, 360 )
        gfx.drawLine( xh+radius, y2,  x2, y2 )
    end

    --Squig.drawLeftHalfSquig( x1, y1,  xh, yh )
    --Squig.drawRightHalfSquig( xh, yh,  x2, y2 )

    return xh, yh
end


function Squig.drawLeftHalfSquig( x1, y1, x2, y2 )
    -- if it's backwards, swap it
    if( x1 > x2 ) then
        x1, y1, x2, y2 = x2, y2, x1, y1 
    end

    local dx = math.abs( x2-x1 )
    local dy = math.abs( y2-y1 )
    local radius = math.floor( math.min( dy/2, dx/2 ))

    if( radius > 32 ) then
        radius = 32
    end

    if( y1 < y2 ) then 
        gfx.drawLine( x1, y1,  x2-radius, y1 )
        gfx.drawArc( x2-radius, y1+radius, radius, 0, 90 )
        gfx.drawLine( x2, y1+radius, x2, y2 )
    else
        gfx.drawLine( x1, y1,  x2-radius, y1 )
        gfx.drawArc( x2-radius, y1-radius, radius, 90, 180 )
        gfx.drawLine( x2, y1-radius, x2, y2 )
    end
end


function Squig.drawRightHalfSquig( x1, y1, x2, y2 )
    -- if it's backwards, swap it
    if( x1 > x2 ) then
        x1, y1, x2, y2 = x2, y2, x1, y1 
    end

    local dx = math.abs( x2-x1 )
    local dy = math.abs( y2-y1 )
    local radius = math.floor( math.min( dy/2, dx/2 ))

    if( radius > 32 ) then
        radius = 32
    end


    if( y1 < y2 ) then 
        -- bottom half
        gfx.drawLine( x1, y1, x1, y2-radius )
        gfx.drawArc( x1+radius, y2-radius, radius, 180, 270 )
        gfx.drawLine( x1+radius, y2,  x2, y2 )
    else
        -- top half
        gfx.drawLine( x1, y1, x1, y2+radius )
        gfx.drawArc( x1+radius, y2+radius, radius, 270, 360 )
        gfx.drawLine( x1+radius, y2,  x2, y2 )
    end
end



function Squig.drawTrioSquig( x1, y1, xC, yC, x2, y2 )
    Squig.drawLeftHalfSquig( x1, y1,  xC, yC )
    Squig.drawRightHalfSquig( xC, yC,  x2, y2 )
end


function Squig.drawTrioPercentSquig( x1, y1, xP, yP, x2, y2 )
    local xC = x1 + ( x2 - x1 ) * xP
    local yC = y1 + ( y2 - y1 ) * yP

    Squig.drawLeftHalfSquig( x1, y1,  xC, yC )
    Squig.drawRightHalfSquig( xC, yC,  x2, y2 )

    return xC, yC
end



