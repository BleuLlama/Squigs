
class('Cursor').extends(playdate.graphics.sprite)

function Cursor:init()
    Cursor.super.init( self )
    self.img_cursor = gfx.image.new("Cursor/cursor")
    self.img_ecks = gfx.image.new("Cursor/ecks")
    self.img_llama = gfx.image.new("Cursor/llama")

    self.posx = 0
    self.posy = 0


	self:setZIndex(32767)
	self:reset()
	self:addSprite()

    self:moveTo(self.posx, self.posy)
    self:add()
end

function Cursor:reset()
    self.posx = displayW/2 + appcfg.grid_x
    self.posy = displayH/2 + appcfg.grid_y

    self:setStyle( 'arrow' )
    self:setStyle( 'normal' )
end


function Cursor:setStyle( v )

    if( v == 'normal' ) then
        self:setImageDrawMode( playdate.graphics.kDrawModeCopy )
        return
    end

    if( v == 'inverted' ) then
        self:setImageDrawMode( playdate.graphics.kDrawModeInverted )
        return
    end

    self:moveTo(0, 0)
    self:setCenter(0.5, 0.5)
    
    if( v == 'ecks' ) then 
        self.frame = self.img_ecks
    elseif( v == 'llama' ) then
        self.frame = self.img_llama
    else  
        self.frame = self.img_cursor
        self:setCenter( 0, 0 )
    end
    self:setImage( self.frame )
    self:moveTo(self.posx, self.posy)
end


function Cursor:constrainedMoveDelta( dx, dy )
    self.posx += dx
    self.posy += dy

    if( self.posx < appcfg.grid_x ) then
        self.posx = appcfg.grid_x
    end

    if( self.posx > displayW - appcfg.grid_x ) then
        self.posx = displayW - appcfg.grid_x ;
    end
    if( self.posy < appcfg.grid_y ) then
        self.posy = appcfg.grid_y;
    end

    if( self.posy > displayH - appcfg.grid_y) then
        self.posy = displayH - appcfg.grid_y;
    end

    self:moveTo( self.posx, self.posy )
end


function Cursor:checkUserInput()
    if playdate.buttonIsPressed( playdate.kButtonUp ) then
        self:constrainedMoveDelta( 0, -appcfg.gridsnap )
    end
    if playdate.buttonIsPressed( playdate.kButtonDown ) then
        self:constrainedMoveDelta( 0, appcfg.gridsnap )
    end
    if playdate.buttonIsPressed( playdate.kButtonRight ) then
        self:constrainedMoveDelta( appcfg.gridsnap, 0 )
    end
    if playdate.buttonIsPressed( playdate.kButtonLeft ) then
        self:constrainedMoveDelta( -appcfg.gridsnap, 0 )
    end
end


function Cursor:update()
    self:checkUserInput();
end