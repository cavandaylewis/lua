-- screen dimensions:(320,568)
----setting the gravity:-(I want 100m/s squared in the x axis and no gravity in the y axis

application:setBackgroundColor(0xffffff)

require "box2d"

local world = b2.World.new(0, 0)

local timer = Timer.new(465, 1)

xRange = 320
yRange = 568

up = Bitmap.new(Texture.new("Buttons/start.png"))
down = Bitmap.new(Texture.new("Buttons/start_down.png"))

up2 = Bitmap.new(Texture.new("Buttons/stop.png"))
down2 = Bitmap.new(Texture.new("Buttons/stop_down.png"))

up3 = Bitmap.new(Texture.new("Buttons/reset.png"))
down3 = Bitmap.new(Texture.new("Buttons/reset_down.png"))

button = Button.new(up, down)
button:setScale(0.4)
button: setPosition(10, 5)
stage:addChild(button)

button2 = Button.new(up2, down2)
button2:setScale(0.4)
button2: setPosition (110, 5)
stage:addChild(button2)

button3 = Button.new(up3, down3)
button3:setScale(0.4)
button3: setPosition (200, 5)
stage:addChild(button3)

local comic =TTFont.new("Text/comic.ttf",100)

local text = TextField.new(comic, "0:00.0")
text:setScale(1)
text:setTextColor(0xaaaaaa)
text:setPosition(application:getDeviceWidth()/2-text:getWidth()/2,application:getDeviceHeight()/2)
stage:addChild(text)

ball = Bitmap.new(Texture.new("Balls/blue-circle.png"))
ball:setScale(0.8)
ball:setAnchorPoint(0.5, 0.5)


local function removeBall()
	stage:removeChild(ball)
end
j=0
p=0
k=0
i = 0

timer = Timer.new(465, 1)
timer2 = Timer.new(93,0)
-- (93,600)=60 seconds

running = false
paused = false
reset = false
ballRelease = false

velocity = 0 
accelaration = 1

function launchBall()
	timer:start()
	
	function onTimer()
		ball:setPosition(math.random(51,279), 60)
		stage:addChild(ball)
		ballRelease = true
	end
	timer:addEventListener(Event.TIMER, onTimer)
end

local function onEnterFrame()
	world:step(1/60, 8, 3)
	if ballRelease == true then
		velocity = velocity+accelaration
		ball:setY(ball:getY()+velocity)
		
		if ball:getY() > 510 then
			ball:setY(510)
			velocity = -velocity
		end
	end
end


function start()
	if running == false and paused == false then
		running = true
		text:setText(j..":"..p..""..k.."."..i)
		timer2:start()
		
		function onTimer2()
			i=i+1
			
			if i==10 then
				i=0
				k=k+1
			end
			
			if k==10 then
				k=0
				p=p+1
			end
			
			if p==6 then
				p=0
				j=j+1
			end
			
			text:setText(j..":"..p..""..k.."."..i)
		end
		launchBall()
		timer2:addEventListener(Event.TIMER, onTimer2)
	elseif paused == true and reset == false then
		running = true
		paused = false
		timer2:resumeAll()
		text:setText(j..":"..p..""..k.."."..i)
		velocity = lastKnownVelocity
		accelaration = 1
	elseif paused == true and reset == true then
		running = true
		paused = false
		reset = false
		accelaration = 1
		timer2:resumeAll()
		ballRelease = false
		launchBall()
	end
end

function stop()
	if running==true then
		text:setText(j..":"..p..""..k.."."..i)
		timer2:pauseAll()
		lastKnownVelocity = velocity
		velocity = 0 
		accelaration = 0
		paused = true
		running = false
		reset = false
	end
end

function reset()
	if running==true then
		j=0
		p=0
		k=0
		i=0
		text:setText(j..":"..p..""..k.."."..i)
		timer2:reset()
		timer2:start()
		text:setText(j..":"..p..""..k.."."..i)
		removeBall()
		velocity = 0
		ballRelease = false
		launchBall()
	elseif paused==true and reset == false then
		reset = true
		j=0
		p=0
		k=0
		i=0
		timer2:resumeAll()
		timer2:reset()
		timer2:start()
		timer2:pauseAll()
		text:setText(j..":"..p..""..k.."."..i)
		removeBall()
	end
end

button:addEventListener("click", start)
button2:addEventListener("click", stop)
button3:addEventListener("click", reset)

stage:addEventListener(Event.ENTER_FRAME, onEnterFrame)