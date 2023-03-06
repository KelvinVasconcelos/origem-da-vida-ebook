local composer = require("composer")
local scene = composer.newScene()

local forwardButton

local function onNextPage( self, event )
	if event.phase == "ended" or event.phase == "cancelled" then
		composer.gotoScene( "src.pages.pageOne", "fade")
		
		return true
	end
  
end

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect(sceneGroup,  "src/assets/background-home.png", display.contentWidth, display.contentHeight)
  background.anchorX = 0
	background.anchorY = 0
	background.x = 0
  background.y = 0
  sceneGroup:insert(background)

  local earth = display.newImageRect('src/assets/earth-home.png', display.contentWidth * 0.8, display.contentWidth * 0.9)
  earth.x = display.contentWidth * 0.3
  earth.y = display.contentWidth * 0.3
  sceneGroup:insert(earth)

  local title = display.newImageRect('src/assets/texts/title.png', display.contentWidth * 0.6, display.contentWidth * 0.13)
  title.x = display.contentWidth * 0.35
  title.y = display.contentWidth * 0.85
  sceneGroup:insert(title)

  forwardButton = display.newImageRect('src/assets/buttons/right-button.png', display.contentWidth * 0.15, display.contentWidth * 0.15)
  forwardButton.x =  display.contentWidth * 0.9
  forwardButton.y = display.contentHeight * 0.9
  sceneGroup:insert(forwardButton)

end

function scene:show( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then

  elseif ( phase == "did" ) then
      
  forwardButton.touch = onNextPage
  forwardButton:addEventListener( "touch", forwardButton )

  end
end

function scene:hide( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
     
  forwardButton:removeEventListener( "touch", forwardButton )

  elseif ( phase == "did" ) then

  end
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )

return scene