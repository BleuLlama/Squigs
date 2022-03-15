-- Llogicr
--  A digital logic toy
--
--  Scott Lawrence - yorgle@gmail.com


-- version history
local app_version = "1.0 2022-03-08"
--  1.0 2022-03-08 - Initial version


-------------------------------------------------
-- standard stuffs
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/math"
import "CoreLibs/timer"

-- our classes
import "moregfx"
import "Cursor/cursor"

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