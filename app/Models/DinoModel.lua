
local DinoModel = class("DinoModel")

DinoModel.ANIMATION_TYPE = {
    RUN = "RUN",
    JUMP = "JUMP",
    CROUCH = "CROUCH",
    FIRE = "FIRE",
}

-- DinoModel.ANIMATION_TYPE.RUN = "RUN"
-- DinoModel.ANIMATION_TYPE.JUMP = "JUMP"
-- DinoModel.ANIMATION_TYPE.CROUCH = "CROUCH"
-- DinoModel.ANIMATION_TYPE.FIRE = "FIRE"

function DinoModel:ctor()
    --[[ self.DINO_BITMASK
    self.DINO_TAG
    self.DINO_ZORDER ]]
    self.position_ = cc.p(145, 170)
    self.initPos_ = self.position_
    --self.animState_ = DinoModel.ANIMATION_TYPE.RUN
    self.isJumping_ = false
    self.isHoldingJump_ = false
    self.hadjumped_ = false
    self.fallSpeed_ = -1
    self.jumpSpeed_ = 10
    self.maxJumpSpeed_ = 15
    self.deltaSpeed_ = self.jumpSpeed_
    self.holdJumpIncre_ = 1.5   -- 必須大於fallSpeed
end

function DinoModel:getPosition()
    return self.position_
end

function DinoModel:getAnimState()
    --return self.animState_
end

function DinoModel:Update(dt)
    if self.isJumping_ then
        self.position_ = self:calcPos(dt)
    end
end

function DinoModel:calcPos(dt)
    -- 持續按住跳躍鍵使Sprite跳得更高
    if self.deltaSpeed_ >= self.maxJumpSpeed_ then 
        self.isHoldingJump_ = false
        self.deltaSpeed_ = self.maxJumpSpeed_
    end
    if self.isHoldingJump_ and self.deltaSpeed_ < self.maxJumpSpeed_ then
        self.deltaSpeed_ = self.deltaSpeed_ + self.holdJumpIncre_
    end

    -- 計算跳躍高度，跳躍速度遞減
    local y = self.position_.y + self.deltaSpeed_
    self.deltaSpeed_ = self.deltaSpeed_ + self.fallSpeed_
    
    -- 位置低於初始高度設為初始高度，並停止跳躍狀態
    if y < self.initPos_.y then 
        y = self.initPos_.y 
        self.isJumping_ = false
        self.deltaSpeed_ = self.jumpSpeed_
        self.hadjumped_ = false
    end
    
    return cc.p(self.initPos_.x, y)
end

function DinoModel:jump()
    if not(self.hadjumped_) then
        self.isHoldingJump_ = true
    end
    self.hadjumped_ = true
    self.isJumping_ = true
    -- animation change to jump state
    --self.animState_ = DinoModel.ANIMATION_TYPE.JUMP
end

function DinoModel:jumpRelease()
    self.isHoldingJump_ = false
end

function DinoModel:run()
    -- animation change to run state
    -- self.animState_ = DinoModel.ANIMATION_TYPE.RUN
end

--[[ 
function DinoModel:crouch()
    -- make Sprite fall faster
    self.fallSpeed_ = self.fallSpeed_ * 2
    -- animation change to fall state
    self.animState_ = DinoModel.ANIMATION_TYPE.CROUCH
end

function DinoModel:unCrouch()
    self.fallSpeed_ = self.fallSpeed_ * 0.5
    -- animation change to run state
    self.animState_ = DinoModel.ANIMATION_TYPE.RUN
end

function DinoModel:fire()
    self.animState_ = DinoModel.ANIMATION_TYPE.FIRE
end
 ]]

return DinoModel