-- SquigDemos
--  Play around with Squigs!
--
--  Scott Lawrence - yorgle@gmail.com


-------------------------------------------------
-- standard stuffs
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/math"
import "CoreLibs/timer"

-- our classes
import "Cursor/cursor"
import "utilities.lua"
import "squigs.lua"

-- shortcuts
gfx = playdate.graphics

displayW = playdate.display.getWidth()
displayH = playdate.display.getHeight()


-- general settings
appcfg = {
    gridsize = 8,
    gridsnap = 8,
    grid_x = 4,
    grid_y = 4,
};