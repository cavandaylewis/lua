-- create a double rod pendulum that demonstrates chaos theory
--use b2 draw and shapes to create the bodys. 
--draw the path of the tip of the 2nd rod.
--320*480

require "box2d"

xRange = 350
yRange = 480

RL=(xRange/4)-2 --Rod length should be (xRange/4)-2
RW=RL/40 --Rod width = RL/40

b2.setScale(30)-- 30 pixels = 1 meter

local world = b2.World.new(0,10)--gravity

local ground = world:createBody{}

local rod = b2.PolygonShape.new()
rod:setAsBox(RL/2,RW/2) -- the x and y distances of the mid point of 
--the box from the origin of the box ie (40,2) makes a box (80*4) big

local point = b2.PolygonShape.new()
point:setAsBox(1,1)

bodyDef1 = {type = b2.DYNAMIC_BODY, position = {x=(xRange/2)+RL/2, y=480}}
body1 = world:createBody(bodyDef1)
fixtureDef1 = {shape = rod, density = 15, restitution = 1, friction = 0}
body1:createFixture(fixtureDef1)
body1:setLinearVelocity(0,10)

bodyDef2 = {type = b2.DYNAMIC_BODY, position = {x=(xRange/2)+3*RL/2, y=480}}
body2 = world:createBody(bodyDef2)
fixtureDef2 = {shape = rod, density = 1, restitution = 1, friction = 0}
body2:createFixture(fixtureDef2)

bodyDef3 = {type = b2.DYNAMIC_BODY, position = {x=(xRange/2)+4*RL/2, y=480}}
body3 = world:createBody(bodyDef3)
fixtureDef3 = {shape = point, density = 0.001, restitution = 1, friction = 0}
body3:createFixture(fixtureDef3)

local jointDef1 = b2.createRevoluteJointDef(body1, ground,xRange/2, 480)
joint1=world:createJoint(jointDef1)

local jointDef2 = b2.createRevoluteJointDef(body2, body1,(xRange/2)+RL, 480)
joint2=world:createJoint(jointDef2)

local jointDef3 = b2.createRevoluteJointDef(body3, body2,(xRange/2)+2*RL, 480)
joint3=world:createJoint(jointDef3)

local debugDraw = b2.DebugDraw.new() 
world:setDebugDraw(debugDraw) 
stage:addChild(debugDraw) 

i=0
j=0

-- step the world at each frame
local function onEnterFrame()
	world:step(1/60, 8, 3)
	
	dotX,dotY=body3:getPosition()
	
	k = math.random(1,3)
	if k ==1 then
		c = 0xff0000
	elseif k==2 then
		c = 0x00ff00
	elseif k==3 then
		c = 0x0000ff
	end

	i = i+1
	dot = {}
	dot[i] = Shape.new()
	dot[i]:setLineStyle(3,c)
	dot[i]:beginPath()
	dot[i]:moveTo(0,0)
	dot[i]:lineTo(0,0)
	dot[i]:closePath()
	dot[i]:endPath()
	--j=j+1
	
	if j == 0 then
		dot[i]:setPosition(dotX, dotY)
		stage:addChild(dot[i])
		j=0
	end
end

stage:addEventListener(Event.ENTER_FRAME, onEnterFrame)