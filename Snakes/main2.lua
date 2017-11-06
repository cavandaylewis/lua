--[[require "box2d"

local world = b2.World.new(0, 0) -- gravity is 0 in x and y direction

xRange = application:getDeviceWidth()
yRange = application:getDeviceHeight()

screenArea = xRange*yRange
scale = math.sqrt((320*568)/screenArea)

startLength = 50*scale

border = Shape.new()
border:setLineStyle(3, 0x000000)
border:beginPath()
border:moveTo(1,1)
border:lineTo(xRange-2,1)
border:lineTo(xRange-2,yRange*0.7)
border:lineTo(1,yRange*0.7)
border:lineTo(1,1)
border:closePath()
border:endPath()
stage:addChild(border)

snake = Shape.new()
snake:setLineStyle(3, 0xff0000)
snakePointX = xRange/2
snakePointY = yRange/2
snake:beginPath()
snake:moveTo(snakePointX, snakePointY)
snake:lineTo(snakePointX, snakePointY+startLength)
snake:closePath()
snake:endPath()
snakeDirection = 3 --1=north, 2=east, 3=south, 4=west
stage:addChild(snake)

velocity = 1*scale

left1 = Bitmap.new(Texture.new("Buttons/left_up.png"))
left2 = Bitmap.new(Texture.new("Buttons/left_down.png"))
right1 = Bitmap.new(Texture.new("Buttons/left_up.png"))
right2 = Bitmap.new(Texture.new("Buttons/left_down.png"))
up1 = Bitmap.new(Texture.new("Buttons/left_up.png"))
up2 = Bitmap.new(Texture.new("Buttons/left_down.png"))
down1 = Bitmap.new(Texture.new("Buttons/left_up.png"))
down2 = Bitmap.new(Texture.new("Buttons/left_down.png"))

left1:setAnchorPoint(0.5,0.5)
left2:setAnchorPoint(0.5,0.5)
right1:setAnchorPoint(0.5,0.5)
right2:setAnchorPoint(0.5,0.5)
up1:setAnchorPoint(0.5,0.5)
up2:setAnchorPoint(0.5,0.5)
down1:setAnchorPoint(0.5,0.5)
down2:setAnchorPoint(0.5,0.5)

leftBtn = Button.new(left1, left2)
rightBtn = Button.new(right1, right2)
upBtn = Button.new(up1, up2)
downBtn = Button.new(down1, down2)

leftBtn:setScale(scale*0.4)
leftBtn:setRotation(0)
leftBtn:setPosition(xRange*0.2,yRange*0.85)
stage:addChild(leftBtn)

rightBtn:setScale(scale*0.4)
rightBtn:setRotation(180)
rightBtn:setPosition(xRange*0.8,yRange*0.85)
stage:addChild(rightBtn)

upBtn:setScale(scale*0.4)
upBtn:setRotation(90)
upBtn:setPosition((xRange*0.5),yRange*0.775)
stage:addChild(upBtn)

downBtn:setScale(scale*0.4)
downBtn:setRotation(270)
downBtn:setPosition((xRange*0.5),yRange*0.925)
stage:addChild(downBtn)

currentX = snakePointX
currentY = snakePointY
length = startLength
a = 0
b = 0
c = 0
d = 0
starting = true
turn = 0

function onUpdate()
	world:step(1/60,8,3)
	if snakeDirection == 1 then --down
		starting = false
		b=0
		c=0
		d=0
		if a == 0 then
			turnPosX = currentX
			turnPosY = currentY
			turn = 1
		end
		a = a+1
		
		if turn == 1 then
			currentX = currentX
			currentY = currentY+velocity
			afterTurnLength = length-(currentY-turnPosY) --the length of the snake after the turn
			snake:clear()
			snake:setLineStyle(3, 0xff0000)
			snake:beginPath()
			snake:moveTo(currentX,currentY)
			snake:lineTo(turnPosX, turnPosY)
			if fromRight == true then
				snake:lineTo(turnPosX-afterTurnLength, turnPosY)
			else
				snake:lineTo(turnPosX+afterTurnLength, turnPosY)
			end
			snake:endPath()
			if currentY >= yRange*0.7 then
				crossBorder = true
			end
			if afterTurnLength <= 0 then
				turn = 0
				fromDown = true
				fromLeft = false
				fromRight = false
			end
		else 
			currentX = currentX
			currentY = currentY+velocity
			
			if currentY >= yRange*0.7 then
				crossBorder = true
				currentY = 3
			end
			
			if crossBorder == true then
				crossBorderLength = length-(currentY-3)
				snake:clear()
				snake:setLineStyle(3, 0xff0000)
				snake:beginPath()
				snake:moveTo(currentX,currentY)
				snake:lineTo(currentX,3)
				snake:moveTo(currentX, yRange*0.7)
				snake:lineTo(currentX, yRange*0.7-crossBorderLength)
				snake:endPath()
				if crossBorderLength <= 0 then
					crossBorder = false
				end
			else
				snake:clear()
				snake:setLineStyle(3, 0xff0000)
				snake:beginPath()
				snake:moveTo(currentX,currentY)
				snake:lineTo(currentX, currentY-length)
				snake:endPath()
			end
		end
		
	elseif snakeDirection == 2 then --right
		starting = false
		a = 0
		c = 0
		d = 0
		if b == 0 then
			turnPosX = currentX
			turnPosY = currentY
			turn = 1
		end
		b = b + 1
		if turn == 1 then
			currentX = currentX+velocity
			currentY = currentY
			afterTurnLength = length-(currentX-turnPosX) --the length of the snake after the turn
			snake:clear()
			snake:setLineStyle(3, 0xff0000)
			snake:beginPath()
			snake:moveTo(currentX,currentY)
			snake:lineTo(turnPosX, currentY)
			if fromUp == true then
				snake:lineTo(turnPosX, turnPosY+afterTurnLength)
			else
				snake:lineTo(turnPosX, turnPosY-afterTurnLength)
			end
			snake:endPath()
			if afterTurnLength <= 0 then
				turn = 0
				fromUp = false
				fromDown = false
				fromRight = true
			end
		else 
			currentX = currentX+velocity
			currentY = currentY
			snake:clear()
			snake:setLineStyle(3, 0xff0000)
			snake:beginPath()
			snake:moveTo(currentX,currentY)
			snake:lineTo(currentX-length, currentY)
			snake:endPath()
		end
		
	elseif snakeDirection == 3 then --up
		if starting == true then 
			turn = 0
		end
		
		a = 0
		b = 0
		d = 0
		
		if c == 0 then
			turnPosX = currentX
			turnPosY = currentY
			turn = 1
		end
		c = c + 1
		
		if turn == 1 then
			currentX = currentX
			currentY = currentY-velocity
			afterTurnLength = length-(turnPosY-currentY) --the length of the snake after the turn
			snake:clear()
			snake:setLineStyle(3, 0xff0000)
			snake:beginPath()
			snake:moveTo(currentX,currentY)
			snake:lineTo(turnPosX, turnPosY)
			if fromRight == true then
				snake:lineTo(turnPosX-afterTurnLength, turnPosY)
			else
				snake:lineTo(turnPosX+afterTurnLength, turnPosY)
			end
			snake:endPath()
			if afterTurnLength <= 0 then
				turn = 0
				fromLeft = false
				fromUp = true
				fromRight = false
			end
		else 
			currentX = currentX
			currentY = currentY-velocity
			snake:clear()
			snake:setLineStyle(3, 0xff0000)
			snake:beginPath()
			snake:moveTo(currentX,currentY)
			snake:lineTo(currentX, currentY+length)
			snake:endPath()
			fromUp = true
		end
		
	elseif snakeDirection == 4 then --left
		starting = false
		a = 0
		b = 0
		c = 0
		if d == 0 then
			turnPosX = currentX
			turnPosY = currentY
			turn = 1
		end
		d = d + 1
		if turn == 1 then
			currentX = currentX-velocity
			currentY = currentY
			afterTurnLength = length-(turnPosX-currentX) --the length of the snake after the turn
			snake:clear()
			snake:setLineStyle(3, 0xff0000)
			snake:beginPath()
			snake:moveTo(currentX,currentY)
			snake:lineTo(turnPosX, turnPosY)
			if fromDown == true then
				snake:lineTo(turnPosX, turnPosY-afterTurnLength)
			else
				snake:lineTo(turnPosX, turnPosY+afterTurnLength)
			end
			snake:endPath()
			if afterTurnLength <= 0 then
				turn = 0
				fromLeft = true
				fromUp = false
				fromDown = false
			end
		else 
			currentX = currentX-velocity
			currentY = currentY
			snake:clear()
			snake:setLineStyle(3, 0xff0000)
			snake:beginPath()
			snake:moveTo(currentX,currentY)
			snake:lineTo(currentX+length, currentY)
			snake:endPath()
		end
		
	end
	
	if currentX == dot:getX() and currentY == dot:getY() then
		length = length + 25
	end
	
end

stage:addEventListener(Event.ENTER_FRAME, onUpdate)

function left()
	if snakeDirection==1 or snakeDirection==3 then
		snakeDirection = 4 --1=north, 2=east, 3=south, 4=west
	end
end

function right()
	if snakeDirection==1 or snakeDirection==3 then
		snakeDirection = 2 --1=north, 2=east, 3=south, 4=west
	end
end

function up()
	if snakeDirection==2 or snakeDirection==4 then
		snakeDirection = 3 --1=north, 2=east, 3=south, 4=west
	end
end

function down()
	if snakeDirection==2 or snakeDirection==4 then
		snakeDirection = 1 --1=north, 2=east, 3=south, 4=west
	end
end

leftBtn:addEventListener("click", left)
rightBtn:addEventListener("click", right)
upBtn:addEventListener("click", up)
downBtn:addEventListener("click", down)
]]