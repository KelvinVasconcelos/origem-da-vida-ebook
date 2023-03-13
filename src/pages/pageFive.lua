local composer = require( "composer" )
local scene = composer.newScene()
local physics = require( "physics" )
local timer = require( "timer" )

local backButton
local forwardButton
local meteorAnimationImage
local dirtImage 
local explosionAnimationImage

local function onBackPage( self, event )
	if event.phase == "ended" or event.phase == "cancelled" then
		composer.gotoScene( "src.pages.pageFour", "fade" )

		return true
	end
end

local function onNextPage( self, event )
	if event.phase == "ended" or event.phase == "cancelled" then
		composer.gotoScene( string.format("src.pages.pageSix"), "fade" )

		return true	
	end
end

local function onCollision(event)
  if event.phase == "began" then
      if (event.object1 == meteorAnimationImage and event.object2 == dirtImage) or
          (event.object1 == dirtImage and event.object2 == meteorAnimationImage) then
          transition.to( meteorAnimationImage, { alpha = 0, time = 300 } )
          transition.to( redRect, { alpha = 1, time = 2000 } )
          explosionAnimationImage.alpha = 1
          timer.performWithDelay( 300, function()
            explosionAnimationImage:play()
          end)
          transition.to( explosion, { alpha = 0, time = 2000 } )
          timer.performWithDelay( 3000, function()
            dirtImage.fill = {type = "image", filename = "src/assets/animations/plants-page-five.png"}
          end)
      end
  end
end

local function onAccelerate( event )
  if event.isShake then
    meteorAnimationImage:play()
    transition.to( meteorAnimationImage, { x = display.contentWidth * 0.5, y = display.contentHeight, time = 2000 } )
  end
end

Runtime:addEventListener("collision", onCollision)
Runtime:addEventListener( "accelerometer", onAccelerate )

function scene:create( event )
	local sceneGroup = self.view

  physics.start()
  physics.setGravity( 0, 0 )

  dirtImage = display.newImageRect('src/assets/animations/dirt-page-five.png', display.contentWidth, display.contentHeight * 0.2)
  dirtImage.x = display.contentWidth * 0.5
  dirtImage.y = display.contentHeight * 0.9
  sceneGroup:insert(dirtImage)
  physics.addBody( dirtImage, "static")

  explosionAnimationImage = graphics.newImageSheet( 'src/assets/animations/explosion-page-five.png', {
    width = 138.4,
    height = 180.5,
    numFrames = 10
  })
  explosionAnimationImage = display.newSprite( explosionAnimationImage,  { 
    name = "normal", 
    start = 1, 
    count = 10, 
    time = 1000, 
    loopCount = 1 
  })
  explosionAnimationImage.x = display.contentWidth * 0.5
  explosionAnimationImage.y = display.contentHeight * 0.85
  explosionAnimationImage.alpha = 0
  explosionAnimationImage:scale(2.5, 2.5)
  sceneGroup:insert( explosionAnimationImage )
  physics.addBody( explosionAnimationImage, "static")

  meteorAnimationImage = graphics.newImageSheet( 'src/assets/animations/meteor-page-five.png', {
    width = 74.4,
    height = 55.8,
    numFrames = 40
  })
  meteorAnimationImage = display.newSprite( meteorAnimationImage,  { 
    name = "normal", 
    start = 1, 
    count = 40, 
    time = 4000, 
    loopCount = 0 
  })
  meteorAnimationImage.x = display.contentWidth * -0.2
  meteorAnimationImage.y = display.contentHeight * -0.2
  meteorAnimationImage:rotate( 20 )
  meteorAnimationImage:scale(4, 4)
  sceneGroup:insert( meteorAnimationImage )
  physics.addBody( meteorAnimationImage, "dynamic", { isSensor = true } )

  local cluePage = display.newImageRect('src/assets/texts/clue-page-five.png', display.contentWidth * 0.8, display.contentWidth * 0.045)
  cluePage.x = display.contentWidth * 0.5
  cluePage.y = display.contentHeight * 0.38
  sceneGroup:insert(cluePage)

  local textPage = display.newImageRect('src/assets/texts/page-five.png', display.contentWidth * 0.8, display.contentWidth * 0.5)
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