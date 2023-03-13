local composer = require( "composer" )
local scene = composer.newScene()

local backButton
local forwardButton
local ellipseImage
local bigBangAnimationImage

local function onBackPage( self, event )
	if event.phase == "ended" or event.phase == "cancelled" then
		composer.gotoScene( "src.pages.pageSix", "fade" )

		return true
	end
end

local function onNextPage( self, event )
	if event.phase == "ended" or event.phase == "cancelled" then
		composer.gotoScene( string.format("src.pages.pageEight"), "fade" )

		return true	
	end
end

local function onTapImage( event )
  transition.to(ellipseImage, {alpha = 0, timer = 1500})
  transition.to(bigBangAnimationImage, {alpha = 1, timer = 3000})
  bigBangAnimationImage:play()
end

function scene:create( event )
	local sceneGroup = self.view

  ellipseImage = display.newImageRect('src/assets/animations/ellipse-page-seven.png', display.contentWidth * 0.05, display.contentWidth * 0.05)
  ellipseImage.x = display.contentWidth * 0.5
  ellipseImage.y = display.contentHeight * 0.2
  sceneGroup:insert(ellipseImage)
  ellipseImage:addEventListener("tap", onTapImage)

  bigBangAnimationImage = graphics.newImageSheet('src/assets/animations/big-bang-page-seven.png', 
  {
    width = 640,
    height = 360,
    numFrames = 36
  })
  bigBangAnimationImage = display.newSprite( bigBangAnimationImage, { name = "run", start = 1, count = 36, time = 3000, loopCount = 1 } )
  bigBangAnimationImage.x = display.contentWidth * 0.5
  bigBangAnimationImage.y = display.contentHeight * 0.2
  bigBangAnimationImage.alpha = 0
  sceneGroup:insert(bigBangAnimationImage)

  local cluePage = display.newImageRect('src/assets/texts/clue-page-seven.png', display.contentWidth * 0.8, display.contentWidth * 0.045)
  cluePage.x = display.contentWidth * 0.5
  cluePage.y = display.contentHeight * 0.38
  sceneGroup:insert(cluePage)

  local textPage = display.newImageRect('src/assets/texts/page-seven.png', display.contentWidth * 0.8, display.contentWidth * 0.37)
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