local composer = require( "composer" )
local physics = require( "physics" )
local scene = composer.newScene()

local backButton
local forwardButton
local flyImage
local potOneImage
local flySmokeAnimationImage

local function onBackPage( self, event )
	if event.phase == "ended" or event.phase == "cancelled" then
		composer.gotoScene( "src.pages.pageOne", "fade" )

		return true
	end
end

local function onNextPage( self, event )
	if event.phase == "ended" or event.phase == "cancelled" then
		composer.gotoScene( string.format("src.pages.pageThree"), "fade" )

		return true	
	end
end

local function onMoveImage(event)
  local target = event.target
  if event.phase == "began" then
    display.getCurrentStage():setFocus(target)
    target.isFocus = true
    target.markX = target.x
    target.markY = target.y
  elseif event.phase == "moved" then
    if target.isFocus then
      local x = (event.x - event.xStart) + target.markX
      local y = (event.y - event.yStart) + target.markY
      target.x, target.y = x, y
    end
  elseif event.phase == "ended" or event.phase == "cancelled" then
    display.getCurrentStage():setFocus(nil)
    target.isFocus = false
  end
end

local function onCollisionImage(event)
  if event.phase == "began" then
      if (event.object1 == flyImage and event.object2 == potOneImage) or
         (event.object1 == potOneImage and event.object2 == flyImage) then
        potOneImage.fill = {type = "image", filename = "src/assets/animations/pot-3-page-two.png"}
        flySmokeAnimationImage.alpha = 1
        flySmokeAnimationImage:play()
      end
  end
end

Runtime:addEventListener("collision", onCollisionImage)

function scene:create( event )
	local sceneGroup = self.view
  physics.start()
  physics.setGravity(0, 0)

  potOneImage = display.newImageRect('src/assets/animations/pot-1-page-two.png', display.contentWidth * 0.2, display.contentWidth * 0.15)
  potOneImage.x = display.contentWidth * 0.35
  potOneImage.y = display.contentHeight * 0.25
  physics.addBody(potOneImage, "static")
  sceneGroup:insert(potOneImage)

  potTwoImage = display.newImageRect('src/assets/animations/pot-2-page-two.png', display.contentWidth * 0.2, display.contentWidth * 0.15)
  potTwoImage.x = display.contentWidth * 0.65
  potTwoImage.y = display.contentHeight * 0.25
  sceneGroup:insert(potTwoImage)

  flyImage = display.newImageRect('src/assets/animations/fly-page-two.png', display.contentWidth * 0.15, display.contentWidth * 0.15)
  flyImage.x = display.contentWidth * 0.8
  flyImage.y = display.contentHeight * 0.1
  sceneGroup:insert(flyImage)
  physics.addBody(flyImage, "dynamic", {isSensor = true})
  flyImage:addEventListener("touch", onMoveImage)

  flySmokeAnimationImage = graphics.newImageSheet('src/assets/animations/fly-smoke-page-two.png', 
  {
    width = 150,
    height = 180,
    numFrames = 25
  })
  flySmokeAnimationImage = display.newSprite( flySmokeAnimationImage, { name = "run", start = 1, count = 25, time = 4000, loopCount = 0 } )
  flySmokeAnimationImage.x = display.contentWidth * 0.35
  flySmokeAnimationImage.y = display.contentHeight * 0.12
  flySmokeAnimationImage.alpha = 0
  flySmokeAnimationImage:scale(0.5, 0.5)
  sceneGroup:insert(flySmokeAnimationImage)

  local cluePage = display.newImageRect('src/assets/texts/clue-page-two.png', display.contentWidth * 0.8, display.contentWidth * 0.045)
  cluePage.x = display.contentWidth * 0.5
  cluePage.y = display.contentHeight * 0.38
  sceneGroup:insert(cluePage)

  local textPage = display.newImageRect('src/assets/texts/page-two.png', display.contentWidth * 0.8, display.contentWidth * 0.42)
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