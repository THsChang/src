local FGModel = class("FGModel")

FGModel.CONSTANT = 
{
    DINO_ZORDER = 50,
    DINO_TAG = 1,
    DINO_BITMASK = 0x01,
    BARRIER_ZORDER = 25,
    BARRIER_TAG = 2,
    BARRIER_BITMASK = 0x03,
    ADD_BARRIER_INTERVAL_MIN = 2,
    ADD_BARRIER_INTERVAL_MAX = 6,
    POS_Y = 175,
}
FGModel.OBJTYPE =
{
    BARRIER, ENEMY
}
function FGModel:rndGenNewObj(objSprite, objModel, objType, scrollSpeed)
    local params = {}
    if objType == FGModel.OBJTYPE.BARRIER then
        params.zorder_ = FGModel.CONSTANT.BARRIER_ZORDER
        params.tag_ = FGModel.CONSTANT.BARRIER_TAG
        params.bitmask_ = FGModel.CONSTANT.BARRIER_BITMASK
        params.initPosY_ = FGModel.CONSTANT.POS_Y
    else
    
    end
    -- 隨機生成障礙, 障礙大小
    local next = tostring(os.time()):reverse():sub(1, 6)
    math.randomseed(next)
    params.scaleFactor_ = 1 + math.random(0, 0.2)
    local fileNr_ = math.random(1, #(objModel.BARRIERS))
    params.fileName_ = objModel.BARRIERS[fileNr_]
    params.scrollSpeed_ = scrollSpeed
    local newObjModel = objModel:create(params)
    
    --print("newObjModel:getFileName()".. newObjModel:getFileName())
    local newObjSprite = objSprite:create(newObjModel)
    --print("rndGenNewObj newObjSprite: "..newObjSprite:getContentSize().width.." "..newObjSprite:getContentSize().height)
    return newObjSprite
end

function FGModel:OnContactBegin(contact)
    local spriteA = contact:getShapeA():getBody():getNode()
    local spriteB = contact:getShapeB():getBody():getNode()
    print("Contacted SpriteA: "..spriteA:getTag().." SpriteB: "..spriteB:getTag())
    if (spriteA and spriteA:getTag() == 1 and spriteB and spriteB:getTag() == 99) or
    (spriteA and spriteA:getTag() == 99 and spriteB and spriteB:getTag() == 1) then
        print("Contacted")
    end
end

return FGModel