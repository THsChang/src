
local BGLayerView = class("BGLayerView", function(layerName)
    local layer  = cc.CSLoader:createNode(layerName)
    return layer
end)

-- Ter = Terrain
function BGLayerView:ctor(layerName, model)
    -- 將循環背景加入 Layer
    self.model_ = model
    self.ter1 = self:getChildByName("terrain")
    self.terSize = self.ter1:getContentSize()
    self.ter2 = cc.Sprite:createWithTexture(self.ter1:getTexture())
    :move(self.terSize.width* 1.5, cc.p(self.ter1:getPosition()).y)
    :addTo(self)
end

-- BGLayerView 更新區塊
function BGLayerView:Update(dt)
    self:moveBG()
end

function BGLayerView:moveBG()
    -- 無限循環背景
    local posTer = 
        self.model_:loopTer(cc.p(self.ter1:getPosition()), cc.p(self.ter2:getPosition()), self.terSize)
    self.ter1:move(posTer[1])
    self.ter2:move(posTer[2])
end


return BGLayerView