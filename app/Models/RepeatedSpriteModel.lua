-- 處理障礙物的位置，出現頻率

local RepeatedSpriteModel = class("RepeatedSpriteModel")
RepeatedSpriteModel.BARRIERS = {
    "b1.png",
    "b2.png",
}
RepeatedSpriteModel.BGELEMENT = {
    "kumo1.png", "kumo2.png",
    "kumo3.png", "kumo4.png",
    "kumo5.png",
}
--[[ RepeatedSpriteModel.IMGTYPE.TYPE1 = "TYPE1"
RepeatedSpriteModel.IMGTYPE.TYPE2 = "TYPE2"
RepeatedSpriteModel.IMGTYPE.TYPE3 = "TYPE3" ]]
function RepeatedSpriteModel:ctor(params)
    self.zorder_ = params.zorder_
    self.tag_ = params.tag_
    self.bitmask_ = params.bitmask_
    self.scaleFactor_ = params.scaleFactor_
    self.imgFileName_ = params.fileName_
    --print("self.imgFileName_"..self.imgFileName_)
    self.scrollSpeed_ = params.scrollSpeed_

    self.position_ = cc.p(display.size.width + 100, params.initPosY_)
end

function RepeatedSpriteModel:Update(dt)
    self.position_ = self:calcPos()
end

function RepeatedSpriteModel:getPos()
    --print("self.position_"..self.position_.x.." "..self.position_.y)
    return self.position_
end

function RepeatedSpriteModel:getFileName()
    return self.imgFileName_
end

function RepeatedSpriteModel:getBitMask()
    return self.bitmask_
end

function RepeatedSpriteModel:getScaleFactor()
    return self.scaleFactor_
end

function RepeatedSpriteModel:getTag()
    return self.tag_
end

function RepeatedSpriteModel:getZorder()
    return self.zorder_
end

function RepeatedSpriteModel:calcPos()
    local retPos = cc.p(self.position_.x-self.scrollSpeed_, self.position_.y)
    return retPos
end

return RepeatedSpriteModel