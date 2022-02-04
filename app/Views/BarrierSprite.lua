local BarrierSprite = class("BarrierSprite", function (model)
    --print("model:getFileName()"..model:getFileName())
    local sprite = display.newSprite(model:getFileName())
    --print("BarrierSprite self: "..sprite:getContentSize().width.." "..sprite:getContentSize().height)
    local body = cc.PhysicsBody:createBox(sprite:getContentSize())
    :setGravityEnable(false)
    :setRotationEnable(false)
    :setContactTestBitmask(model:getBitMask())
    sprite:setPhysicsBody(body)
    sprite:setTag(model:getTag())
    return sprite
end)

function BarrierSprite:ctor(model)
    --print("BarrierSprite:ctor")
    self.model_ = model
    --print("model:getFileName()"..model:getFileName())
    --self = display.newSprite(model:getFileName())
    --print("BarrierSprite self: "..self:getContentSize().width.." "..self:getContentSize().height)
    --[[ local body = cc.PhysicsBody:createBox(self:getContentSize())
    :setGravityEnable(false)
    :setRotationEnable(false)
    :setContactTestBitmask(model:getBitMask())
    self:setPhysicsBody(body)
    self:setTag(model:getTag()) ]]
end

function BarrierSprite:Update(dt)
    --print("BarrierSprite:Update")
    self.model_:Update()
    self:move(self.model_:getPos())
end

function BarrierSprite:getModel()
    return self.model_
end

function BarrierSprite:deleteSelf()
    if self.model_:getPos().x <= 0 - self:getContentSize().width*0.5 then
        self:removeSelf()
        return true
    end
    return false
end

return BarrierSprite