-- 管理dino Sprite、動畫
local DinoSprite = class("DinoSprite", function(imageFilename)
    --[[ local texture = display.getImage(imageFilename)
    local frameWidth = texture:getPixelsWide() / 3
    local frameHeight = texture:getPixelsHigh()

    local spriteFrame = display.newSpriteFrame(texture, cc.rect(0, 0, frameWidth, frameHeight))
    local sprite = display.newSprite(spriteFrame) ]]
    local sprite = display.newSprite(imageFilename)
    --[[ sprite.frameWidth_ = sprite
    sprite.frameHeight_ = sprite ]]
    -- 添加physicsBody至Sprite中
    local body = cc.PhysicsBody:createBox(sprite:getContentSize())
        :setGravityEnable(false)
        :setRotationEnable(false)
        :setContactTestBitmask(0x03)
    sprite:setPhysicsBody(body)
    
    return sprite
end)
function DinoSprite:ctor(imageFilename, dinoModel)
    self.model_ = dinoModel
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




return DinoSprite
