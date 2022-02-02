
local FGCtrler = class("FGCtrler", cc.Node)

local DinoModel = import("..Models.DinoModel")
local DinoSprite = import("..Views.DinoSprite")
local BarrierModel = import("..Models.BarrierModel")
local BarrierSprite = import("..Views.BarrierSprite")
local FGModel = import("..Models.FGModel")

-- 處理使用者事件
function FGCtrler:ctor(scrollSpeed)
    self.scrollSpeed_ = scrollSpeed
    self.DinoModel = DinoModel:create()
    self.DinoSprite = DinoSprite:create("Cocos.png", self.DinoModel):addTo(self)

    self.Barriers = {}
    self.addBarrierInterval_ = 0
    -- 設定鍵盤監聽器
    local kBListener = cc.EventListenerKeyboard:create()
    kBListener:registerScriptHandler(
        handler(self.DinoSprite, self.DinoSprite.onKeyPressed), cc.Handler.EVENT_KEYBOARD_PRESSED)
    kBListener:registerScriptHandler(
        handler(self.DinoSprite, self.DinoSprite.onKeyReleased), cc.Handler.EVENT_KEYBOARD_RELEASED)
    local Dispatcher = cc.Director:getInstance():getEventDispatcher()
    Dispatcher:addEventListenerWithSceneGraphPriority(kBListener, self)
    -- 設定物件碰撞監聽器
    
    local contactListener = cc.EventListenerPhysicsContact:create()
    contactListener:registerScriptHandler(handler(self, FGModel.OnContactBegin), cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
    Dispatcher:addEventListenerWithSceneGraphPriority(contactListener, self)
end

function FGCtrler:Start()
    self:onUpdate(handler(self, self.Update), 0)
    return self
end

function FGCtrler:Update(dt)
    self.DinoSprite:Update(dt)
    self.addBarrierInterval_ = self.addBarrierInterval_ - dt
    if self.addBarrierInterval_ <= 0 then
        print("Watashiwakita")
        local next = tostring(os.time()):reverse():sub(1, 6)
        math.randomseed(next)
        self.addBarrierInterval_ = 
            math.random(FGModel.CONSTANT.ADD_BARRIER_INTERVAL_MIN, FGModel.CONSTANT.ADD_BARRIER_INTERVAL_MAX)
        local newBarrierObj = 
            FGModel:rndGenNewObj(BarrierSprite, BarrierModel, FGModel.OBJTYPE.BARRIER, self.scrollSpeed_):addTo(self)
        --print("newBarrierObj"..newBarrierObj:getContentSize().width.." "..newBarrierObj:getContentSize().height)
        table.insert(self.Barriers, 1, newBarrierObj)
    end
    print("self.Barriers"..#(self.Barriers))
    for k, v in ipairs(self.Barriers) do
        v:toString()
        v:Update(dt)
        if v:deleteSelf() then
            self.Barriers[k] = nil
        end
    end
end


return FGCtrler