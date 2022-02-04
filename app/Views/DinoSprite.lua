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
    run = 6,
    crouch = 6 
}


function DinoSprite:ctor(imageFilename, dinoModel)
    --self.fileName_ = imageFilename
    self.model_ = dinoModel
    self.animRunAction = self:createAimation("run")
    self:setTag(1)
    self:runAction(cc.RepeatForever:create(self.animRunAction))
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
    self.model_:Update(dt)
    self:move(self.model_:getPosition())
end

function DinoSprite:chageAnim(animState)
    -- call moDel to change sprite's animation
    -- call corresponding transformation to make sprite move
    --   e.g. while jump call jump to make sprite move
    --self.playAnimationForever(display.getAnimationCache(animState))

end

function DinoSprite:onKeyPressed(keyCode, event)
    if keyCode == 59 then
        print("KEY space PRESSED")
        self.model_:jump()
    end
end

function DinoSprite:onKeyReleased(keyCode, event)
    if keyCode == 59 then
        print("KEY space Released")
        self.model_:jumpRelease()
    end
end

function DinoSprite:createAimation(spriteFrameName)
    local spriteFrame = cc.SpriteFrameCache:getInstance()
    --run
    if spriteFrameName == "run" then
        local animRun = cc.Animation:create()
        for i = 1, DinoSprite.frameNr.run do
            local frameName = string.format("%s_%d.png",spriteFrameName, i)
            local spriteFrame = spriteFrame:getSpriteFrame(frameName)
            animRun:addSpriteFrame(spriteFrame)
        end
        animRun:setDelayPerUnit(0.08)
        animRun:setRestoreOriginalFrame(true)
        return cc.Animate:create(animRun)
    end
    
    --crouch
    --jump
end




return DinoSprite
