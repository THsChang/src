local BGLayerModel = class("BGLayerModel")

function BGLayerModel:ctor(scrollSpeed)
    self.winSize_ = display.size
    self.scrollSpeed_ = scrollSpeed
    self.ZORDER_RNDOBJ = 20
end

-- 處理無限循環背景(Update控制)
local terFLAG = -1
function BGLayerModel:loopTer(posTer1, posTer2, terSize)
    local targetPosTer
    local retPos1 = cc.p(posTer1.x-self.scrollSpeed_, posTer1.y)
    local retPos2 = cc.p(posTer2.x-self.scrollSpeed_, posTer2.y)
    
    if terFLAG == -1 then
        targetPosTer = retPos1
    else targetPosTer = retPos2 end

    if targetPosTer.x + terSize.width * 0.5 <= 0 then
        local initPos = cc.p(terSize.width * 1.5, targetPosTer.y)
        if terFLAG == -1 then
            retPos1 = initPos
        else retPos2 = initPos end
        terFLAG = terFLAG * -1
    end
    return {retPos1, retPos2}
end

-- 隨機生成背景物件, e.g. 星星, 山巒, 雲, ... (Update控制)

-- 設定常數:背景物件的重生區間最小、最大值
function BGLayerModel:randomCreateBGObj(dt)
    -- 隨機給一計時變數於上述常數之最小~最大區間值
    -- 使用"計時變數"每次loop減去 dt(Delta Time)
    -- 當"計時變數" <= 0時隨機生成背景物件
    -- 對隨機生成物件給予隨機移動速度, 需小於等於scrollSpeed_
    -- 給一陣列存取所有背景物件,針對每個物件執行向左移動
end

return BGLayerModel