
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

MainScene.RESOURCE_FILENAME = "MainScene.csb"

function MainScene:onCreate()
    printf("resource node = %s", tostring(self:getResourceNode()))
    cc.MenuItemFont:setFontSize(86)
    local isPhysic, drawDebug = true, true
    local playButton = cc.MenuItemFont:create("Start"):onClicked(function()
        self:getApp():enterScene("PlayScene", "FADE", 0.5, _, isPhysic, drawDebug)
    end)
    cc.MenuItemFont:setFontSize(40)
    local quitButton = cc.MenuItemFont:create("Quit"):onClicked(function()
        cc.Director:getInstance():endToLua()
    end)
    cc.Menu:create(playButton,quitButton):alignItemsVertically():addTo(self)
end

return MainScene
