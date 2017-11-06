--320*480

require "box2d"

--sets the gravity
local world = b2.World.new(0,0)

width = application:getDeviceWidth()
height = application:getDeviceHeight()

local up = Bitmap.new(Texture.new("button_up.png"))
local down = Bitmap.new(Texture.new("button_down.png"))

local button = Button.new(up, down)
button:setScale(0.5)
button:setPosition(width/2-button:getWidth()/2, 20)
stage:addChild(button)

--creation of the ground
local ground = world:createBody{}
local shape = b2.EdgeShape.new()
shape:set(1,1,0,height)
ground:createFixture({shape = shape, density = 0, friction = 0})

local shape2 = b2.EdgeShape.new()
shape2:set(0,height,width,height)
ground:createFixture({shape = shape2, density = 0, friction = 0})

local shape3 = b2.EdgeShape.new()
shape3:set(width,height,width,0)
ground:createFixture({shape = shape3, density = 0, friction = 0})

local shape4 = b2.EdgeShape.new()
shape4:set(width,0,1,1)
ground:createFixture({shape = shape4, density = 0, friction = 0})

local gravity = 1

--creating and launching the ball
function launchBall()
	x = math.random(0,width-25)
	y = math.random(0,height-25)
	--xVelocity=(0)
	--yVelocity=(0)
	xVelocity = math.random(-15,15)
	yVelocity = math.random(-15,15)
	
	local bodyDef = {type = b2.DYNAMIC_BODY, position = {x=x, y=y}}
	bullet = world:createBody(bodyDef)
	local shape = b2.CircleShape.new(0,0,25)
	local fixtureDef = {shape = shape, density = 10, restitution = 1, friction = 0}
	bullet:createFixture(fixtureDef)
	bullet:setLinearVelocity(xVelocity, yVelocity)
	bullet:setSleepingAllowed(false)
	
	bullet.sprite=Bitmap.new(Texture.new("red-circle.png"))
	bullet.sprite:setAnchorPoint(0.5,0.5)
	stage:addChild(bullet.sprite)
	
	return bullet
end

local sprite = Bitmap.new(Texture.new("red-circle.png"))
sprite:setAnchorPoint(0.5,0.5)

--makes the ball and ground visable
local debugDraw = b2.DebugDraw.new()
world:setDebugDraw(debugDraw)
stage:addChild(debugDraw)

density= 10
radius =25

local function onEnterFrame()
	world:step(1/60,8,3)
	for i = 1,#atom do
		atom[i].sprite:setPosition(atom[i]:getPosition())
		atom[i].sprite:setRotation(atom[i]:getAngle()*180/math.pi)
	end

	energy=0
	meanVelocity=0
	totalVelocity=0
	momentumX=0
	momentumY=0
	total = 0

if gravity==1 then
	for i=1, #atom do
		velocityX,velocityY = atom[i]:getLinearVelocity()
		--mass = area*density
		mass = bullet:getMass()
		energy=energy+1/2*mass*(math.sqrt(velocityX^2+velocityY^2))^2
		
		totalVelocity=velocityX+velocityY
		momentumX=momentumX+mass*velocityX
		momentumY=momentumY+mass*velocityY
	end
	text:setText("Kinetic: "..energy.." J")
	--print(momentumX, momentumY)
else 
	for i = 1, #atom do
		area = math.pi*(radius/b2.getScale())^2
		velocityX,velocityY = atom[i]:getLinearVelocity()
		mass = bullet:getMass()
		energy=energy+1/2*mass*(math.sqrt(velocityX^2+velocityY^2))^2
		
		X, Y = atom[i]:getPosition()
		potential = mass*world:getGravity()*(height-Y)/30
		total = total+energy+potential
		
	end
	text:setText("Kinetic: "..energy)
	print (total)
end
end

text = TextField.new(nil, "")
text:setTextColor(0xff0000)
text:setScale(1)
text:setPosition(20,20)
stage:addChild(text)

atom={}
for i=1,10 do
	atom[i] = launchBall()
end

text2 = TextField.new(nil, "gravity: off")
text2:setScale(2)
text2:setPosition(width/2,height-20)
stage:addChild(text2)



function toggle ()
	if gravity==1 then
		gravity = 0
		text2:setText("gravity: on")
		world:setGravity(0,10)
	else
		gravity = 1
		text2:setText("gravity: off")
		world:setGravity(0,0)
	end
end

button:addEventListener("click", toggle)
stage:addEventListener(Event.ENTER_FRAME, onEnterFrame)

