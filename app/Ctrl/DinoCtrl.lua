
local DinoCtrl = class("DinoCtrl")

local DinoModel = import("..Ctrl.DinoCtrl")
local DinoSprite = import("..views.DinoSprite")

-- 處理使用者事件
function DinoCtrl:ctor()
    self.DinoNode = display.newNode():addTo(self)
    self.model_ = DinoModel:create()
    self.view_ = DinoSprite:create("cocos.png", self.model_)
    local listener = cc.EventListenerKeyboard:create()

    listener:registerScriptHandler(onSpacePressed, cc.Handler.EVENT_KEYBOARD_PRESSED)
    listener:registerScriptHandler(onSpaceReleased, cc.Handler.EVENT_KEYBOARD_RELEASED)

    self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self)
end
function DinoCtrl:step()
    self.view_:step()
end
function DinoCtrl:getView()
    return self.view_
end

function DinoCtrl:onSpacePressed(keyCode, event)
    targetCode = cc.EventKeyboard.KEY_UP_ARROW
    self.model_:jump()
end

function DinoCtrl:onSpaceReleased(keyCode, event)

end

return DinoCtrl