local BGLayerModel = class("BGLayerModel")

BGLayerModel.CONSTANT = {

    BGELEMENT_ZORDER = 20,
    ADD_BGELEMENT_INTERVAL_MIN = 1,
    ADD_BGELEMENT_INTERVAL_MAX = 2,
}

-- 處理無限循環背景(Update控制)
local terFLAG = -1
function BGLayerModel:loopTer(posTer1, posTer2, terSize, scrollSpeed)
    local targetPosTer
    local retPos1 = cc.p(posTer1.x-scrollSpeed, posTer1.y)
    local retPos2 = cc.p(posTer2.x-scrollSpeed, posTer2.y)
    
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

function BGLayerModel:rndGenNewObj(objSprite, objModel, scrollSpeed)
    local params = {}
    params.zorder_ = BGLayerModel.CONSTANT.BGELEMENT_ZORDER
    -- 隨機生成障礙, 障礙大小
    local next = tostring(os.time()):reverse():sub(1, 6)
    math.randomseed(next)
    params.initPosY_ = math.random(260, 640)
    params.scaleFactor_ = 1 + math.random(0, 0.5)
    local fileNr_ = math.random(1, #(objModel.BGELEMENT))
    params.fileName_ = objModel.BGELEMENT[fileNr_]
    params.scrollSpeed_ = scrollSpeed
    local newObjModel = objModel:create(params)
    
    --print("newObjModel:getFileName()".. newObjModel:getFileName())
    local newObjSprite = objSprite:create(newObjModel)
    --print("rndGenNewObj newObjSprite: "..newObjSprite:getContentSize().width.." "..newObjSprite:getContentSize().height)
    return newObjSprite
end

return BGLayerModel