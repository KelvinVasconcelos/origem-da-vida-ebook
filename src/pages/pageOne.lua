local composer = require( "composer" )
local scene = composer.newScene()

local backButton
local forwardButton
local rockImage
local horseAnimationImage

local function onBackPage( self, event )
	if event.phase == "ended" or event.phase == "cancelled" then
		composer.gotoScene( "src.pages.eBookCover", "fade" )

		return true
	end
end

local function onNextPage( self, event )
	if event.phase == "ended" or event.phase == "cancelled" then
		composer.gotoScene( string.format("src.pages.pageTwo"), "fade" )

		return true	
	end
end

local function onTapImage( event )
  transition.to(rockImage, {alpha = 0, timer = 1500})
  transition.to(horseAnimationImage, {alpha = 1, timer = 3000})
  horseAnimationImage:play()
end


function scene:create( event )
	local sceneGroup = self.view

  rockImage = display.newImageRect('src/assets/animations/rock-page-one.png', display.contentWidth * 0.3, display.contentWidth * 0.3)
  rockImage.x = display.contentWidth * 0.5
  rockImage.y = display.contentHeight * 0.2
  sceneGroup:insert(rockImage)
  rockImage:addEventListener("tap", onTapImage)

  horseAnimationImage = graphics.newImageSheet('src/assets/animations/horse-page-one.png', 
  {
    width = 500,
    height = 271,
    numFrames = 12
  })
  horseAnimationImage = display.newSprite( horseAnimationImage, { name = "run", start = 1, count = 12, time = 1000, loopCount = 0 } )
  horseAnimationImage.x = display.contentWidth * 0.5
  horseAnimationImage.y = display.contentHeight * 0.2
  horseAnimationImage.alpha = 0
  sceneGroup:insert(horseAnimationImage)

  local cluePage = display.newImageRect('src/assets/texts/clue-page-one.png', display.contentWidth * 0.8, display.contentWidth * 0.045)
  cluePage.x = display.contentWidth * 0.5
  cluePage.y = display.contentHeight * 0.38
  sceneGroup:insert(cluePage)

  local textPage = display.newImageRect('src/assets/texts/page-one.png', display.contentWidth * 0.8, display.contentWidth * 0.42)
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
  rockImage:removeEventListener( "tap", rockImage)

  elseif ( phase == "did" ) then

  end
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )

return scene