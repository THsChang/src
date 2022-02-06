-- 管理dino Sprite、動畫


local DinoSprite = class("DinoSprite", function(imageFilename)
    local spriteFrame = cc.SpriteFrameCache:getInstance()
    spriteFrame:addSpriteFrames("noUsagi.plist", "noUsagi.png")
    
    local sprite = cc.Sprite:createWithSpriteFrameName("run_1.png")
    -- 添加physicsBody至Sprite中
    local body = cc.PhysicsBody:createBox(sprite:getContentSize())
        :setGravityEnable(false)
        :setRotationEnable(false)
        :setContactTestBitmask(0x03)
    sprite:setPhysicsBody(body)
    return sprite
end)

DinoSprite.frameNr = {
    ["run"] = 6,
    ["dead"] = 1 ,
    ["crouch"] = 6 ,
    ["jump"] = {2,1,2,2}
}

function DinoSprite:ctor(imageFilename, dinoModel)
    --self.fileName_ = imageFilename
    self.model_ = dinoModel
    self.prevModelAniStatus = dinoModel.ANIMATION_TYPE.RUN
    -- self.animListener = cc.EventListenerCustom:create("ANIMCHANGED_EVENT", handler(self, self.chageAnim))
    -- cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(self.animListener, self)

    local jumpAnimActions = self:createAimation("jump")
    self.animAction = {
        ["run"] = self:createAimation("run"),
        ["crouch"] = self:createAimation("crouch"),
        ["dead"] = self:createAimation("dead"),
        ["jump1"] = jumpAnimActions[1],
        ["jump2"] = jumpAnimActions[2],
        ["jump3"] = jumpAnimActions[3],
        ["jump4"] = jumpAnimActions[4],
    }
    self:runAction(self.animAction["run"])
    self:setTag(1)
end

function DinoSprite:getModel()
    return self.model_
end

function DinoSprite:start()
    -- play idle animation
    self.model_:run()
    --self:playAnimationForever(display.getAnimationCache(self.model_:getAnimState()))
end

function DinoSprite:Update(dt)
    local state = self.model_:getAnimState()
    if(state ~= self.prevModelAniStatus) then
        self:stopAllActions()
        self:runAction(self.animAction[state])
        self.prevModelAniStatus = state
    end
    if self.model_:Update(dt) then
        self:move(self.model_:getPosition())
    else
        local event = cc.EventCustom:new("DEADEVENT")
        local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
        eventDispatcher:dispatchEvent(event)
    end

end

function DinoSprite:chageAnim(event)
    local animState = self.model_:getAnimState()
    self:runAction(self.animAction[animState])
end

function DinoSprite:onKeyPressed(keyCode, event)
    print(keyCode)
    if keyCode == 59 then
        print("KEY space PRESSED")
        self.model_:jump()
        return
    end
    if  keyCode == 28 then
        
        print("KEY up PRESSED")
        return
    end
    if  keyCode == 29 then
        self.model_:crouch()
        print("KEY down PRESSED")
        return
    end
end

function DinoSprite:onKeyReleased(keyCode, event)
    if keyCode == 59 then
        print("KEY space Released")
        self.model_:jumpRelease()
    end
    if  keyCode == 28 then
        print("KEY up PRESSED")
        return
    end
    if  keyCode == 29 then
        self.model_:unCrouch()
        print("KEY down PRESSED")
        return
    end
end

function DinoSprite:createAimation(spriteFrameName)
    local spriteFrame = cc.SpriteFrameCache:getInstance()

    --jump
    if spriteFrameName == "jump" then
        local animActions = {}
        local jumpFrameNrs = DinoSprite.frameNr[spriteFrameName]
        local frameIndex = 1
        for i = 1, #(jumpFrameNrs) do
            local animation = cc.Animation:create()
            for j = 1, jumpFrameNrs[i] do
                local frameName = string.format("%s_%d.png",spriteFrameName, frameIndex)
                local spriteFrame = spriteFrame:getSpriteFrame(frameName)
                animation:addSpriteFrame(spriteFrame)
                frameIndex = frameIndex + 1
            end
            animation:setDelayPerUnit(0.08)
            animation:setRestoreOriginalFrame(false)
            local action = cc.Animate:create(animation)
            action:retain()
            table.insert(animActions, action)
        end
        return animActions
    end
    --crouch, run
    local animation = cc.Animation:create()
    for i = 1, DinoSprite.frameNr[spriteFrameName] do
        local frameName = string.format("%s_%d.png",spriteFrameName, i)
        local spriteFrame = spriteFrame:getSpriteFrame(frameName)
        animation:addSpriteFrame(spriteFrame)
    end
    animation:setDelayPerUnit(0.08)
    animation:setRestoreOriginalFrame(true)
    local action = cc.RepeatForever:create(cc.Animate:create(animation))
    action:retain()
    return action
end

return DinoSprite
