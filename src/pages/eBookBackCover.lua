local composer = require("composer")
local scene = composer.newScene()

local backButton

local function onBackPage( self, event )
	if event.phase == "ended" or event.phase == "cancelled" then
		composer.gotoScene( "src.pages.pageEight", "fade" )

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

  local author = display.newImageRect('src/assets/texts/author.png', display.contentWidth * 0.75, display.contentWidth * 0.05)
  author.x = display.contentWidth * 0.5
  author.y = display.contentWidth * 0.1
  sceneGroup:insert(author)

  local subtitle = display.newImageRect('src/assets/texts/subtitle.png', display.contentWidth * 0.6, display.contentWidth * 0.05)
  subtitle.x = display.contentWidth * 0.5
  subtitle.y = display.contentWidth * 0.2
  sceneGroup:insert(subtitle)

  local title = display.newImageRect('src/assets/texts/title.png', display.contentWidth * 0.75, display.contentWidth * 0.16)
  title.x = display.contentWidth * 0.5
  title.y = display.contentWidth * 0.6
  sceneGroup:insert(title)

  local upeLogo = display.newImageRect('src/assets/texts/upe-logo.png', display.contentWidth * 0.25, display.contentWidth * 0.16)
  upeLogo.x = display.contentWidth * 0.5
  upeLogo.y = display.contentWidth
  sceneGroup:insert(upeLogo)

  local discipline = display.newImageRect('src/assets/texts/discipline.png', display.contentWidth * 0.4, display.contentWidth * 0.05)
  discipline.x = display.contentWidth * 0.5
  discipline.y = display.contentHeight * 0.9
  sceneGroup:insert(discipline)

  backButton = display.newImageRect('src/assets/buttons/left-button.png', display.contentWidth * 0.15, display.contentWidth * 0.15)
  backButton.x =  display.contentWidth * 0.1
  backButton.y = display.contentHeight * 0.9
  sceneGroup:insert(backButton)

end

function scene:show( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then

  elseif ( phase == "did" ) then
      
  backButton.touch = onBackPage
  backButton:addEventListener( "touch", backButton )

  end
end

function scene:hide( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
     
  backButton:removeEventListener( "touch", backButton )

  elseif ( phase == "did" ) then

  end
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )

return scene