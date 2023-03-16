local composer = require( "composer" )
local physics = require( "physics" )
local timer = require( "timer" )
local scene = composer.newScene()

local backButton
local forwardButton
local hidrogenioImage
local amoniaImage
local metanoImage
local experimentAnimationImage
local countImages = 0

local function onBackPage( self, event )
	if event.phase == "ended" or event.phase == "cancelled" then
		composer.gotoScene( "src.pages.pageFive", "fade" )

		return true
	end
end

local function onNextPage( self, event )
	if event.phase == "ended" or event.phase == "cancelled" then
		composer.gotoScene( string.format("src.pages.pageSeven"), "fade" )

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

local function displayAnimation()
  if countImages >= 3 then
    experimentAnimationImage:play()
  end
end

local function onCollisionImage(event)
  local object1 = event.object1
  local object2 = event.object2

  if event.phase == "began" then
    if (object1 == hidrogenioImage and object2 == experimentAnimationImage) or 
      (object1 == experimentAnimationImage and object2 == hidrogenioImage) then
        countImages = countImages + 1
        displayAnimation()

    elseif (object1 == amoniaImage and object2 == experimentAnimationImage) or
      (object1 == experimentAnimationImage and object2 == amoniaImage) then
        countImages = countImages + 1
        displayAnimation()

    elseif (object1 == metanoImage and object2 == experimentAnimationImage) or
      (object1 == experimentAnimationImage and object2 == metanoImage) then
        countImages = countImages + 1
        displayAnimation()
    end
  end
end

Runtime:addEventListener("collision", onCollisionImage)

function scene:create( event )
	local sceneGroup = self.view
  physics.start()
  physics.setGravity(0, 0)

  experimentAnimationImage = graphics.newImageSheet('src/assets/animations/experiment-page-six.png', 
  {
    width = 620,
    height = 349,
    numFrames = 109
  })
  experimentAnimationImage = display.newSprite( experimentAnimationImage, { name = "run", start = 1, count = 109, time = 5000, loopCount = 0 } )
  experimentAnimationImage.x = display.contentWidth * 0.5
  experimentAnimationImage.y = display.contentHeight * 0.2
  physics.addBody(experimentAnimationImage, "static", { radius = 100 })
  sceneGroup:insert(experimentAnimationImage)

  hidrogenioImage = display.newImageRect('src/assets/animations/hidrogenio-page-six.png', display.contentWidth * 0.15, display.contentWidth * 0.08)
  hidrogenioImage.x = display.contentWidth * 0.75
  hidrogenioImage.y = display.contentHeight * 0.2
  sceneGroup:insert(hidrogenioImage)
  physics.addBody(hidrogenioImage, "dynamic", {isSensor = true})
  hidrogenioImage:addEventListener("touch", onMoveImage)

  amoniaImage = display.newImageRect('src/assets/animations/amonia-page-six.png', display.contentWidth * 0.15, display.contentWidth * 0.08)
  amoniaImage.x = display.contentWidth * 0.9
  amoniaImage.y = display.contentHeight * 0.15
  sceneGroup:insert(amoniaImage)
  physics.addBody(amoniaImage, "dynamic", {isSensor = true})
  amoniaImage:addEventListener("touch", onMoveImage)

  metanoImage = display.newImageRect('src/assets/animations/metano-page-six.png', display.contentWidth * 0.15, display.contentWidth * 0.08)
  metanoImage.x = display.contentWidth * 0.75
  metanoImage.y = display.contentHeight * 0.1
  sceneGroup:insert(metanoImage)
  physics.addBody(metanoImage, "dynamic", {isSensor = true})
  metanoImage:addEventListener("touch", onMoveImage)

  local cluePage = display.newImageRect('src/assets/texts/clue-page-six.png', display.contentWidth * 0.8, display.contentWidth * 0.045)
  cluePage.x = display.contentWidth * 0.5
  cluePage.y = display.contentHeight * 0.38
  sceneGroup:insert(cluePage)

  local textPage = display.newImageRect('src/assets/texts/page-six.png', display.contentWidth * 0.8, display.contentWidth * 0.42)
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