local composer = require( "composer" )
local physics = require( "physics" )
local scene = composer.newScene()

local backButton
local forwardButton
local fireAnimationImage
local glassImage

local function onBackPage( self, event )
	if event.phase == "ended" or event.phase == "cancelled" then
		composer.gotoScene( "src.pages.pageTwo", "fade" )

		return true
	end
end

local function onNextPage( self, event )
	if event.phase == "ended" or event.phase == "cancelled" then
		composer.gotoScene( string.format("src.pages.pageFour"), "fade" )

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

function scene:create( event )
	local sceneGroup = self.view

  glassImage = display.newImageRect('src/assets/animations/glass-page-three.png', display.contentWidth * 0.4, display.contentWidth * 0.35)
  glassImage.x = display.contentWidth * 0.5
  glassImage.y = display.contentHeight * 0.22
  sceneGroup:insert(glassImage)

  fireAnimationImage = graphics.newImageSheet('src/assets/animations/fire-page-three-four.png', 
  {
    width = 498,
    height = 498,
    numFrames = 35
  })
  fireAnimationImage = display.newSprite( fireAnimationImage, { name = "run", start = 1, count = 35, time = 2000, loopCount = 0 } )
  fireAnimationImage.x = display.contentWidth * 0.8
  fireAnimationImage.y = display.contentHeight * 0.1
  fireAnimationImage:scale(0.4, 0.4)
  fireAnimationImage:play()
  sceneGroup:insert(fireAnimationImage)
  physics.addBody(fireAnimationImage, "dynamic", {isSensor = true})
  fireAnimationImage:addEventListener("touch", onMoveImage)

  local cluePage = display.newImageRect('src/assets/texts/clue-page-three.png', display.contentWidth * 0.8, display.contentWidth * 0.045)
  cluePage.x = display.contentWidth * 0.5
  cluePage.y = display.contentHeight * 0.38
  sceneGroup:insert(cluePage)

  local textPage = display.newImageRect('src/assets/texts/page-three.png', display.contentWidth * 0.8, display.contentWidth * 0.2)
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