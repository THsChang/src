
local BGCtrler = class("BGCtrler", cc.Node)

local BGLayerView = import("..Views.BGLayerView")
local BGLayerModel = import("..Models.BGLayerModel")

function BGCtrler:ctor(scrollSpeed)
    self.BGLayerModel = BGLayerModel:create(scrollSpeed)
    self.BGLayerView = BGLayerView:create("BGLayer.csb", self.BGLayerModel):addTo(self)
end

function BGCtrler:Start()
    self:onUpdate(handler(self, self.Update), 0)
    return self
end

function BGCtrler:Update()
    self.BGLayerView:Update()
end

return BGCtrler