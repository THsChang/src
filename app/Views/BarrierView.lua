local BarrierView = class("BarrierView", function(imageFilename)
    local sprite = display.newSprite(imageFilename)
    local body = cc.PhysicsBody:createBox(sprite:getContentSize())
    :setGravityEnable(false)
    :setRotationEnable(false)
    :setContactTestBitmask(0x01)
    sprite:setPhysicsBody(body)
    return sprite
end)

function BarrierView:ctor(imageFilename, model)
    self.model_ = model
    self:setTag(1)
end

function BarrierView:getModel()
    return self.model_
end

function BarrierView:Update(dt)
    self.model_:Update()
    self:move(self.model_:getPos())
end

function BarrierView:deleteSelf()
    if self.model_:getPos().x <= 0 then
        self:removeSelf()
        return true
    end
    return false
end

return BarrierView