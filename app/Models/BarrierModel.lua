-- 處理障礙物的位置，出現頻率

local BarrierModel = class("BarrierModel")
BarrierModel.FILES = {
    "b1.png",
    "b2.png",
    -- "TYPE3",
}
--[[ BarrierModel.IMGTYPE.TYPE1 = "TYPE1"
BarrierModel.IMGTYPE.TYPE2 = "TYPE2"
BarrierModel.IMGTYPE.TYPE3 = "TYPE3" ]]
function BarrierModel:ctor(params)
    self.zorder_ = params.zorder_
    self.tag_ = params.tag_
    self.bitmask_ = params.bitmask_
    self.scaleFactor_ = params.scaleFactor_
    self.imgFileName_ = BarrierModel.FILES[params.fileNr_]
    print("params.fileNr_"..params.fileNr_)
    print("self.imgFileName_"..self.imgFileName_)
    self.scrollSpeed_ = params.scrollSpeed_

    self.position_ = cc.p(display.size.width + 50, 170)
end

function BarrierModel:Update(dt)
    self.position_ = self:calcPos()
end

function BarrierModel:getPos()
    print("self.position_"..self.position_.x.." "..self.position_.y)
    return self.position_
end

function BarrierModel:getFileName()
    return self.imgFileName_
end

function BarrierModel:getBitMask()
    return self.bitmask_
end

function BarrierModel:getTag()
    return self.tag_
end

function BarrierModel:getZorder()
    return self.zorder_
end

function BarrierModel:calcPos()
    local retPos = cc.p(self.position_.x-self.scrollSpeed_, self.position_.y)
    return retPos
end

return BarrierModel