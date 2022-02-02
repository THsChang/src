
local PlayView = class("PlayView", cc.load("mvc").ViewBase)

local DinoCtrl = import("..Ctrl.DinoCtrl")
PlayView.RESOURCE_FILENAME = "PlayLayer.csb"
local PlayLayer
local Terrain
local TerrainClone
local winSize
local TerrainSize
local scrollSpeed = 5

function PlayView:Start()
    self:onUpdate(handler(self, self.step), 0)
    return self
end

function PlayView:onCreate()
    PlayLayer = self:getResourceNode()
    Terrain = PlayLayer:getChildByName("terrain")
    winSize = display.size
    TerrainSize = Terrain:getContentSize()
    self:addToLayer()
    DinoCtrl:create()
    self:onNodeEvent("exit", function()
        self:unscheduleUpdate()
    end)
end

-- 將循環背景&碰撞範圍加入Layer
function PlayView:addToLayer()
    -- 循環背景
    TerrainClone = cc.Sprite:createWithTexture(Terrain:getTexture())
    local pos = cc.p(Terrain:getPosition())
    TerrainClone:setPosition(TerrainSize.width* 1.5, pos.y)
    TerrainClone:addTo(PlayLayer)

    local material = cc.PhysicsMaterial(10, 0, 0)
    -- 世界邊界
    local edgeSize = cc.p(winSize.width, winSize.height) --- (pos.y+TerrainSize.height*0.5))
    local body = cc.PhysicsBody:createEdgeBox(winSize, material, 5.0)
    local edgeNode = cc.Node:create()
    --edgeNode:setAnchorPoint(0.5, 1)
    edgeNode:setPosition(cc.p(display.cx, display.cy))
    edgeNode:setPhysicsBody(body):addTo(PlayLayer)

    local sp = PlayLayer:getChildByName("CocosSP")
    local body1 = cc.PhysicsBody:createBox(sp:getContentSize(), material)
    sp:setPhysicsBody(body1)
end

-- PlayView更新區塊
function PlayView:step(dt)
    -- 無限循環背景
    self:loopTerrain()
    DinoCtrl:step()
    -- 隨機生成背景物件
    
end

-- 處理無限循環背景(Update控制)
local TerrainFLAG = -1
function PlayView:loopTerrain()
    local targetTerrain
    if TerrainFLAG == -1 then targetTerrain = Terrain
    else targetTerrain = TerrainClone end
    local posTarget = cc.p(targetTerrain:getPosition())

    if posTarget.x + TerrainSize.width * 0.5 <= 0 then
        targetTerrain:setPosition(TerrainSize.width * 1.5, posTarget.y)
        TerrainFLAG = TerrainFLAG * -1
    end
    local posTerrain = cc.p(Terrain:getPosition())
    local posTerrainClone = cc.p(TerrainClone:getPosition())
    Terrain:setPosition(posTerrain.x-scrollSpeed, posTerrain.y)
    TerrainClone:setPosition(posTerrainClone.x-scrollSpeed, posTerrainClone.y)
end

-- 隨機生成背景物件, e.g. 星星, 山巒, 雲, ... (Update控制)

-- 設定常數:背景物件的重生區間最小、最大值
function PlayView:randomCreateBGObj(dt)
    -- 隨機給一計時變數於上述常數之最小~最大區間值
    -- 使用"計時變數"每次loop減去 dt(Delta Time)
    -- 當"計時變數" <= 0時隨機生成背景物件
    -- 對隨機生成物件給予隨機移動速度, 需小於等於scrollSpeed
    -- 給一陣列存取所有背景物件,針對每個物件執行向左移動
end

return PlayView