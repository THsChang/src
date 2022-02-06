
local DinoModel = class("DinoModel")

DinoModel.ANIMATION_TYPE = {
    RUN = "run", JUMP1 = "jump1", JUMP2 = "jump2",
    JUMP3 = "jump3", JUMP4 = "jump4", CROUCH = "crouch",
    FIRE = "fire", DEAD = "dead"
}

function DinoModel:ctor()
    --[[ self.DINO_BITMASK
    self.DINO_TAG
    self.DINO_ZORDER ]]
    self.position_ = cc.p(145, 160)
    self.initPos_ = self.position_
    self.animState_ = DinoModel.ANIMATION_TYPE.RUN

    self.isJumping_ = false
    self.isHoldingJump_ = false
    self.hadjumped_ = false
    self.fallSpeed_ = -1
    self.jumpSpeed_ = 10
    self.maxJumpSpeed_ = 15
    self.deltaSpeed_ = self.jumpSpeed_
    self.holdJumpIncre_ = 1.5   -- 必須大於fallSpeed
    self.isLive = true
end

function DinoModel:getPosition()
    return self.position_
end

function DinoModel:getAnimState()
    return self.animState_
end

function DinoModel:Update(dt)
    if self.isJumping_ then
        self.position_ = self:calcPos(dt)
    end
    print("DinoModel:dead()")
    print(self.isLive)
    return self.isLive
end
local isJumpStop = false
local isJumpFall = false
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
    print("y: "..y.." self.initPos_.y: ",self.initPos_.y)
    -- if delta 1 > speed >-1 動畫狀態切為JUMP制空狀態
    if self.deltaSpeed_ <= 0.5 then
        self.animState_ = DinoModel.ANIMATION_TYPE.JUMP2
    end

    if self.deltaSpeed_ < -0.5 then
        self.animState_ = DinoModel.ANIMATION_TYPE.JUMP3
    end

    if y < self.initPos_.y - 15 then 
        self.animState_ = DinoModel.ANIMATION_TYPE.JUMP4
        self.deltaSpeed_ = self.jumpSpeed_
        y = self.initPos_.y -10
    -- 位置低於初始高度設為初始高度，並更改狀態為RUN
    elseif y < self.initPos_.y then 
        y = self.initPos_.y 
        self.isJumping_ = false
        self.deltaSpeed_ = self.jumpSpeed_
        self.hadjumped_ = false
        isJumpStop = false
        isJumpFall = false
        self:run()
    end
    
    return cc.p(self.initPos_.x, y)
end

function DinoModel:jump()
    if not(self.hadjumped_) then
        self.isHoldingJump_ = true
        self.animState_ = DinoModel.ANIMATION_TYPE.JUMP1
    end
    self.hadjumped_ = true
    self.isJumping_ = true
    -- animation change to jump state
end

function DinoModel:jumpRelease()
    self.isHoldingJump_ = false
end

function DinoModel:run()
    -- animation change to run state
    self.animState_ = DinoModel.ANIMATION_TYPE.RUN
end

function DinoModel:crouch()
    -- make Sprite fall faster
    local inverse = 1
    if  self.deltaSpeed_ > 0 then
        inverse = -1
    end
    self.deltaSpeed_ = -15
    -- animation change to fall state
    self.animState_ = DinoModel.ANIMATION_TYPE.CROUCH
end

function DinoModel:unCrouch()
    -- animation change to run state
    self.animState_ = DinoModel.ANIMATION_TYPE.RUN
end
function DinoModel:dead()
    self.animState_ = DinoModel.ANIMATION_TYPE.DEAD
    self.isLive = false
    print("DinoModel:dead()")
    print(self.isLive)

end
--[[ 
function DinoModel:fire()
    self.animState_ = DinoModel.ANIMATION_TYPE.FIRE
end
 ]]

return DinoModel