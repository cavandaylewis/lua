
xRange = application:getDeviceWidth()
yRange = application:getDeviceHeight()

scale = math.sqrt((xRange*yRange)/(320*568))
length = 50*scale

box = Shape.new()
box:setLineStyle(5*scale , 0x0000ff)
box:beginPath()
box:moveTo(0,0)
box:lineTo(length,0)
box:lineTo(length, length)
box:lineTo(0,length)
box:closePath()
box:endPath()
xPos = math.random(3,xRange-length-3)
yPos = math.random(3,yRange-length-3)
box:setPosition(xPos, yPos)
stage:addChild(box)

boxDown = Shape.new()
boxDown:setLineStyle(5*scale , 0x00ff00)
boxDown:beginPath()
boxDown:moveTo(0,0)
boxDown:lineTo(length,0)
boxDown:lineTo(length, length)
boxDown:lineTo(0,length)
boxDown:closePath()
boxDown:endPath()
boxDown:setPosition(xPos, yPos)
stage:addChild(boxDown)

boxBtn = Button.new(box, boxDown)
stage:addChild(boxBtn)

gameOverTxt1 = TextField.new(nil, "Game Over")
gameOverTxt1:setScale(4*scale)
gameOverTxt1:setPosition((xRange*0.5)-(gameOverTxt1:getWidth()*0.5),(yRange*0.5)-(gameOverTxt1:getHeight()*0.5))

gameOverTxt2 = TextField.new(nil, "Game Over")
gameOverTxt2:setTextColor(0x00ff00)
gameOverTxt2:setScale(4*scale)
gameOverTxt2:setPosition((xRange*0.5)-(gameOverTxt1:getWidth()*0.5),(yRange*0.5)-(gameOverTxt1:getHeight()*0.5))

gameOver = Button.new(gameOverTxt1, gameOverTxt2)

line = Shape.new()
line:setLineStyle(5*scale, 0xff0000)
line:beginPath()
line:moveTo(0,0)
line:endPath()
stage:addChild(line)

score = 0
text = TextField.new(nil, score)
text:setScale(4*scale)
text:setPosition((xRange/2)-(text:getWidth()/2), yRange*0.9)
stage:addChild(text)


timeAllowed = 140

atEnd = false
starting = true

i = 0

function newBox()
	if starting == false then
		timer:stop()
	end
	starting = false
	timer = Timer.new(10, timeAllowed)
	i = 0
	timer:addEventListener(Event.TIMER, onTimer)
	timer:addEventListener(Event.TIMER_COMPLETE, onTimerComplete)
	timer:start()
end

function onTimer()
	line:clear()
	line:setLineStyle(5*scale, 0x000000)
	line:beginPath()
	line:moveTo(length/2,0)
	i = i + 1
	position = (i/timeAllowed)*4*length
	if position <= (length/2) then
		line:lineTo((length/2)+position,0)
	elseif position > (length/2) and position <= (length*1.5) then
		line:lineTo(length, 0)
		line:lineTo(length, position-(length/2))
	elseif position > (length*1.5) and position <= (length*2.5) then
		line:lineTo(length, 0)
		line:lineTo(length, length)
		line:lineTo(length-(position-(length*1.5)),length)
	elseif position > (length*2.5) and position <= (length*3.5) then
		line:lineTo(length, 0)
		line:lineTo(length, length)
		line:lineTo(0, length)
		line:lineTo(0, length-(position-(length*2.5)))
	elseif position > (length*3.5) then
		line:lineTo(length, 0)
		line:lineTo(length, length)
		line:lineTo(0, length)
		line:lineTo(0,0)
		line:lineTo(position-(length*3.5),0)
	end
	line:endPath()
	
end

function onBoxClick()
	if atEnd == false and starting == false then
		xPos = math.random(3,xRange-length-3)
		yPos = math.random(3,yRange-length-3)
		box:setPosition(xPos, yPos)
		boxDown:setPosition(xPos, yPos)
		line:setPosition(xPos, yPos)
		timeAllowed = timeAllowed-10
		--print(timeAllowed)
		score = score + 1
		text:setText(score)
		newBox()
	elseif atEnd==false and starting == true then
		xPos = math.random(3,xRange-length-3)
		yPos = math.random(3,yRange-length-3)
		box:setPosition(xPos, yPos)
		boxDown:setPosition(xPos, yPos)
		line:setPosition(xPos, yPos)
		--print(timeAllowed)
		text:setText(score)
		newBox()
	end
end

function onTimerComplete(e)
	--stage:addChild(boxEnd)
	atEnd = true
	stage:addChild(gameOver)
end

function onGameOverClick()
	timeAllowed = 140
	score = 0
	text:setText(score)
	atEnd = false
	stage:removeChild(gameOver)
	newBox()
end

boxBtn:addEventListener("click", onBoxClick)
gameOver:addEventListener("click", onGameOverClick)