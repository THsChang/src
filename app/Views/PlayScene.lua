
local PlayScene = class("PlayScene", cc.load("mvc").ViewBase)

PlayScene.RESOURCE_FILENAME = "PlayScene.csb"
local BGCtrler = import("..Ctrler.BGCtrler")
local FGCtrler = import("..Ctrler.FGCtrler")

local scrollSpeed = 10
function PlayScene:onCreate()
    self.BGCtrler = BGCtrler:create(scrollSpeed)
    :Start()
    :addTo(self)

    self.FGCtrler = FGCtrler:create(scrollSpeed)
    :Start()
    :addTo(self)
    --[[ self.GameCtrler = GameCtrler:create()
    :Start()
    :addTo(self)
     ]]
end

return PlayScene