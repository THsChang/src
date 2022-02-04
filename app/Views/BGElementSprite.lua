local BGElementSprite = class("BGElementSprite", function (model)
    --print("model:getFileName()"..model:getFileName())
    local spriteFrame = cc.SpriteFrameCache:getInstance()
    spriteFrame:addSpriteFrames("repeatedSprite.plist", "repeatedSprite.png")
    local sprite = cc.Sprite:createWithSpriteFrameName(model:getFileName())
    return sprite
end)

function BGElementSprite:ctor(model)
    self.model_ = model
    self:setScale(model:getScaleFactor())
end

function BGElementSprite:Update()
    self.model_:Update()
    self:move(self.model_:getPos())
end

function BGElementSprite:getModel()
    return self.model_
end

function BGElementSprite:deleteSelf()
    if self.model_:getPos().x <= 0 - self:getContentSize().width*0.5 then
        self:removeSelf()
        return true
    end
end

return BGElementSprite