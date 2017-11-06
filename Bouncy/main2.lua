-- screen dimensions:(320,480)
----setting the gravity:-(I want 100m/s squared in the x axis and no gravity in the y axis
--[[
application:setBackgroundColor(0xffffff)

require "box2d"

b2.setScale(30)
local world = b2.World.new(0, 0)

local timer = Timer.new(465, 1)

Gravity = 0

local ground = world:createBody{}

--creates the line objects can collide with
local shape = b2.EdgeShape.new()

--here i am setting the dimension of the edge's (x,y,x,y)
shape:set(20, 460, 300, 460)
ground:createFixture({shape = shape, density = 0})

--timer:addEventListener(Event.TIMER, launchBall2)

local up = Bitmap.new(Texture.new("Buttons/start.png"))
local down = Bitmap.new(Texture.new("Buttons/start_down.png"))

local up2 = Bitmap.new(Texture.new("Buttons/stop.png"))
local down2 = Bitmap.new(Texture.new("Buttons/stop_down.png"))

local up3 = Bitmap.new(Texture.new("Buttons/reset.png"))
local down3 = Bitmap.new(Texture.new("Buttons/reset_down.png"))

local button = Button.new(up, down)
button:setScale(0.4)
button: setPosition(10, 5)
stage:addChild(button)

local button2 = Button.new(up2, down2)
button2:setScale(0.4)
button2: setPosition (110, 5)
stage:addChild(button2)

local button3 = Button.new(up3, down3)
button3:setScale(0.4)
button3: setPosition (200, 5)
stage:addChild(button3)

local comic =TTFont.new("Text/comic.ttf",100)

local text = TextField.new(comic, "0:00.0")
text:setScale(1)
text:setTextColor(0xaaaaaa)
text:setPosition(application:getDeviceWidth()/2-text:getWidth()/2,application:getDeviceHeight()/2)
stage:addChild(text)

local actors = {}

local sprite = Bitmap.new(Texture.new("Balls/blue-circle.png", true))

--local body = world:createBody{type = b2.DYNAMIC_BODY, position = {0, 0}}

local function removeBall()
	body:setPosition(-100,100)
	--world:destroyBody(body)
end

local bob=1

local dave = blah

local j=0

local p=0

local k=0

local i = 0

local click = 0

local timer2 = Timer.new(93,0)
--0 = running--start-nothing, stop-stop reset-reset and keep going
--1 = never been run
--2 = Finished -N/A
--3 = paused
-- (93,600)=60 seconds

function launchBall()
	local function createCircle(texture, x, y, filter)
		body = world:createBody{type = b2.DYNAMIC_BODY, position = {x = x, y = y}}
		shape = b2.CircleShape.new(0, 0, 20)
		body:createFixture{shape = shape, density = 1, restitution = 1, filter=filter}
		sprite:setScale(1/5*4)
		sprite:setAnchorPoint(0.5, 0.5)
		stage:addChild(sprite)
		actors[body] = sprite
	end
	world:setGravity(0,10)
	createCircle("Balls/blue-circle.png", (math.random(51,279)), 60)
end

function start()
	if bob == 1 then
		bob=0
		timer:start()
		text:setText(j..":"..p..""..k.."."..i)
		timer2:start()
		
		function onTimer2()
			i=i+1
			
			if p==6 then
				p=0
				j=j+1
			end
			
			if k==10 then
				k=0
				p=p+1
			end
			
			if i==10 then
				i=0
				k=k+1
			end
			
			text:setText(j..":"..p..""..k.."."..i)
		end
		
		function onTimerComplete(e)
			text:setText(j..":"..p..""..k.."."..i)
			world=b2.World.new(0, 0)
			bob=2
		end
		
		timer:addEventListener(Event.TIMER, launchBall)
		timer2:addEventListener(Event.TIMER, onTimer2)
	elseif bob==0 then
		dave=blahblah
	elseif bob==2 then
		timer2:reset()
		timer2:start()
	elseif bob==3 then
		bob=0
		timer2:resumeAll()
		text:setText(j..":"..p..""..k.."."..i)
		world:setGravity(0,10)
		body:setLinearVelocity(velocityX, velocityY)
	end
end

button:addEventListener("click", start)

-- step the world at each frame
local function onEnterFrame()
	world:step(1/60, 8, 3)
	
	for body,sprite in pairs(actors) do
		sprite:setPosition(body:getPosition())
		sprite:setRotation(body:getAngle() * 180 / math.pi)
	end
end

stage:addEventListener(Event.ENTER_FRAME, onEnterFrame)

function stop()
	if bob==0 then
		text:setText(j..":"..p..""..k.."."..i)
		timer2:pauseAll()
		world:setGravity(0, 0)
		velocityX,velocityY = body:getLinearVelocity()
		body:setLinearVelocity(0,0)
		bob = 3
	elseif bob==1 then
		
	elseif bob==2 then
		
	elseif bob==3 then
		
	end
end

button2:addEventListener("click", stop)

function reset()
	if bob==0 then
		j=0
		p=0
		k=0
		i=0
		text:setText(j..":"..p..""..k.."."..i)
		timer2:stop()
		timer2:reset()
		timer2:start()
		text:setText(j..":"..p..""..k.."."..i)
		removeBall()
		launchBall()
	elseif bob==1 then
		j=0
		p=0
		k=0
		i=0
		--timer2:reset()
		text:setText(j..":"..p..""..k.."."..i)
	elseif bob==2 then
		bob=1
		j=0
		p=0
		k=0
		i=0
		timer2:reset()
		text:setText(j..":"..p..""..k.."."..i)
		removeBall()
	elseif bob==3 then
		bob=1
		j=0
		p=0
		k=0
		i=0
		timer2:resumeAll()
		timer2:stop()
		timer2:reset()
		text:setText(j..":"..p..""..k.."."..i)
		removeBall()
	end
end

button3:addEventListener("click", reset)
]]