
local PlayScene = class("PlayScene", cc.load("mvc").ViewBase)

PlayScene.RESOURCE_FILENAME = "PlayScene.csb"
local BGCtrler = import("..Ctrler.BGCtrler")
local FGCtrler = import("..Ctrler.FGCtrler")

local scrollSpeed = 10
function PlayScene:onCreate()
    self:setZOrder(0)
    self.BGCtrler = BGCtrler:create(scrollSpeed)
    :Start()
    :addTo(self)

    self.FGCtrler = FGCtrler:create(scrollSpeed)
    :Start()
    :addTo(self)
    local GameStopListener = cc.EventListenerCustom:create("DEADEVENT", handler(self, self.StopScene))
    local Dispatcher = cc.Director:getInstance():getEventDispatcher()
    Dispatcher:addEventListenerWithSceneGraphPriority(GameStopListener, self)
    --[[ self.GameCtrler = GameCtrler:create()
    :Start()
    :addTo(self)
     ]]
end

function PlayScene:StopScene(event)
    local layer = cc.Layer:create()
    self.BGCtrler:Stop()
    self.FGCtrler:Stop()
    --[[ local restartButton = cc.MenuItemImage:create(
        "re_up.png",
        "re_dwn.png"
    )--:setPosition(cc.Director:getInstance():convertToGL(cc.p(display.cx, display.cy)))
    :registerScriptTapHandler(handler(self, self.restartClick))
    local mn = cc.Menu:create(restartButton):setPosition(cc.p(0, 0)):addTo(layer, 99)
    layer:addTo(self) ]]
end

function PlayScene:restartClick(sender)
    print("restart Game")
end

return PlayScene