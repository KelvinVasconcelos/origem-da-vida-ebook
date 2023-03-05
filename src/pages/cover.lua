local utils = require("utils")
local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local bg = display.newImageRect(sceneGroup,  "src/assets/background-home.png", display.contentWidth, display.contentHeight)
  bg.anchorX = 0
	bg.anchorY = 0
	bg.x = 0
  bg.y = 0

  local earth = display.newImageRect('src/assets/earth-home.png', display.contentWidth * 0.8, display.contentWidth * 0.9)
  earth.x = display.contentWidth * 0.3
  earth.y = display.contentWidth * 0.3

  local title = display.newImageRect('src/assets/texts/title.png', display.contentWidth * 0.6, display.contentWidth * 0.12)
  title.x = display.contentWidth * 0.35
  title.y = display.contentWidth * 0.85

  local forwardButton = display.newImageRect('src/assets/buttons/right-button.png', display.contentWidth * 0.15, display.contentWidth * 0.15)
  forwardButton.x =  display.contentWidth * 0.9
  forwardButton.y = display.contentHeight * 0.9
  

end


scene:addEventListener( "create", scene )

return scene