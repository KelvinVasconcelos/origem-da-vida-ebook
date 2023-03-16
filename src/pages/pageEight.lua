local composer = require( "composer" )
local scene = composer.newScene()

local backButton
local forwardButton
local dedoImage
local earthAnimationImage

local function onBackPage( self, event )
	if event.phase == "ended" or event.phase == "cancelled" then
		composer.gotoScene( "src.pages.pageSeven", "fade" )

		return true
	end
end

local function onNextPage( self, event )
	if event.phase == "ended" or event.phase == "cancelled" then
		composer.gotoScene( string.format("src.pages.eBookBackCover"), "fade" )

		return true	
	end
end

local function onAccelerate( event )
  if event.isShake then
    earthAnimationImage.alpha = 1
    earthAnimationImage:play()
  end
end

Runtime:addEventListener("accelerometer", onAccelerate )

function scene:create( event )
	local sceneGroup = self.view

  earthAnimationImage = graphics.newImageSheet('src/assets/animations/earth-page-eight.png', 
  {
    width = 256,
    height = 163,
    numFrames = 74
  })
  earthAnimationImage = display.newSprite( earthAnimationImage, { name = "run", start = 1, count = 74, time = 3000, loopCount = 0 } )
  earthAnimationImage.x = display.contentWidth * 0.5
  earthAnimationImage.y = display.contentHeight * 0.2
  earthAnimationImage:scale(2,2)
  earthAnimationImage.alpha = 0
  sceneGroup:insert(earthAnimationImage)

  local cluePage = display.newImageRect('src/assets/texts/clue-page-eight.png', display.contentWidth * 0.8, display.contentWidth * 0.045)
  cluePage.x = display.contentWidth * 0.5
  cluePage.y = display.contentHeight * 0.38
  sceneGroup:insert(cluePage)

  local textPage = display.newImageRect('src/assets/texts/page-eight.png', display.contentWidth * 0.8, display.contentWidth * 0.52)
  textPage.x = display.contentWidth * 0.5
  textPage.y = display.contentHeight * 0.62
  sceneGroup:insert(textPage)

  backButton = display.newImageRect('src/assets/buttons/left-button.png', display.contentWidth * 0.15, display.contentWidth * 0.15)
  backButton.x =  display.contentWidth * 0.1
  backButton.y = display.contentHeight * 0.9
  sceneGroup:insert(backButton)

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
      
  backButton.touch = onBackPage
	backButton:addEventListener( "touch", backButton )

  forwardButton.touch = onNextPage
	forwardButton:addEventListener( "touch", forwardButton )

  end
end

function scene:hide( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
     
  backButton:removeEventListener( "touch", backButton )
  forwardButton:removeEventListener( "touch", forwardButton )

  elseif ( phase == "did" ) then

  end
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )

return scene