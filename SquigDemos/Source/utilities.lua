-- Utilities
--  Misc helpers
--
--  Scott Lawrence - yorgle@gmail.com


displayW = playdate.display.getWidth()
displayH = playdate.display.getHeight()


function math.div( a, b )
    return math.floor(a/b)*b
end


function math.ring(a, min, max)
    if min > max then
        min, max = max, min
    end
    return min + (a-min)%(max-min)
end

function math.ring_int(a, min, max)
    return math.ring(a, min, max+1)
end

function math.clamp(a, min, max)
    if min > max then
        min, max = max, min
    end
    return math.max(min, math.min(max, a))
end


function table.random( t )
    if type(t)~="table" then return nil end
    return t[math.ceil(math.random(#t))]
end

function table.each( t, fn )
	if type(fn)~="function" then return end
	for _, e in pairs(t) do
		fn(e)
	end
end

-- from http://lua-users.org/wiki/SimpleRound
-- rounds v to the number of places in bracket, i.e. 0.01, 0.1, 1, 10, etc
function math.round(v, bracket)
    local bracket = bracket or 1
    return math.floor(v/bracket + math.sign(v) * 0.5) * bracket
  end
  -- round needs sign:
  function math.sign(v)
    return (v >= 0 and 1) or -1
  end

  
--------------------------------------------------------
-- draw a grid


class('LlamaGfx').extends( Object )

function LlamaGfx.draw_grid( offset_x, offset_y, gridsize )
    local gfx = playdate.graphics

    for x = 0, displayW, gridsize do
        for y = 0, displayH-gridsize, gridsize do
            gfx.drawPixel( offset_x + x, offset_y + y )
        end
    end
end

function LlamaGfx.drawCrosshairs( mx, my )
    gfx.drawLine( mx, 0, mx, displayH )
    gfx.drawLine( 0, my, displayW, my )
end

