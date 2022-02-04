
local BGCtrler = class("BGCtrler", cc.Node)

local BGLayerView = import("..Views.BGLayerView")
local BGLayerModel = import("..Models.BGLayerModel")
local BGElementSprite = import("..Views.BGElementSprite")
local RepeatedSpriteModel = import("..Models.RepeatedSpriteModel")
function BGCtrler:ctor(scrollSpeed)
    self.scrollSpeed_ = scrollSpeed
    self.BGLayerView_ = BGLayerView:create("BGLayer.csb", BGLayerModel, scrollSpeed):addTo(self, 20)
    self.BGElements = {0,0,0,0,0}
    self.addElementInterval_ = 0
end

function BGCtrler:Start()
    self:onUpdate(handler(self, self.Update), 0)
    return self
end

function BGCtrler:Update(dt)
    self.BGLayerView_:Update()
    self:BGEleManage(dt)
end

-- 隨機生成背景物件, e.g. 星星, 山巒, 雲, ... (Update控制)
-- 設定常數:背景物件的重生區間最小、最大值
function BGCtrler:BGEleManage(dt)
    self.addElementInterval_ = self.addElementInterval_ - dt
    
    for k,v in ipairs(self.BGElements) do
        if(v == 0) then
            if self.addElementInterval_ <= 0 then
                --print("Watashiwakita")
                local next = tostring(os.time()):reverse():sub(1, 6)
                math.randomseed(next)
                self.addElementInterval_ = 
                    math.random(BGLayerModel.CONSTANT.ADD_BGELEMENT_INTERVAL_MIN, BGLayerModel.CONSTANT.ADD_BGELEMENT_INTERVAL_MAX)
                
                local rndScrollSpeed = math.random(5, self.scrollSpeed_)
                local newElementObj = 
                    BGLayerModel:rndGenNewObj(BGElementSprite, RepeatedSpriteModel, rndScrollSpeed)
                newElementObj:addTo(self.BGLayerView_, newElementObj:getModel():getZorder())
                --print("newElementObj"..newElementObj:getContentSize().width.." "..newElementObj:getContentSize().height)
                self.BGElements[k] = newElementObj
                --self.BGElements[newElementObj] = newElementObj
            end
        else
            v:Update(dt)
            if v:deleteSelf() then
                self.BGElements[k] = 0
            end
        end
    end
    print("self.BGElements"..#(self.BGElements))

    -- 隨機給一計時變數於上述常數之最小~最大區間值
    -- 使用"計時變數"每次loop減去 dt(Delta Time)
    -- 當"計時變數" <= 0時隨機生成背景物件
    -- 對隨機生成物件給予隨機移動速度, 需小於等於scrollSpeed_
    -- 給一陣列存取所有背景物件,針對每個物件執行向左移動
end

function BGCtrler:CheckCloud()
    for index, value in ipairs(self.BGElements) do
        if(value == 0) then
            return true
        end
    end
end

return BGCtrler