require "box2d"

local world = b2.World.new(0, 0) -- gravity is 0 in x and y direction

xRange = application:getDeviceWidth()
yRange = application:getDeviceHeight()

screenArea = xRange*yRange
scale = math.sqrt(screenArea/(320*568))

startLength = 50*scale

border = Shape.new()
border:setLineStyle(3*scale, 0x000000)
border:beginPath()
border:moveTo(1,1)
border:lineTo(xRange-2,1)
border:lineTo(xRange-2,yRange*0.7)
border:lineTo(1,yRange*0.7)
border:lineTo(1,1)
border:closePath()
border:endPath()
stage:addChild(border)

gameOverTxt1 = TextField.new(nil,"Game Over")
gameOverTxt1:setScale(4*scale)
gameOverTxt1:setPosition((xRange/2)-(gameOverTxt1:getWidth()/2), ((yRange*0.7)/2)-(gameOverTxt1:getHeight()/2))

gameOverTxt2 = TextField.new(nil,"Game Over")
gameOverTxt2:setScale(4*scale)
gameOverTxt2:setTextColor(0x00ff00)
gameOverTxt2:setPosition((xRange/2)-(gameOverTxt2:getWidth()/2), ((yRange*0.7)/2)-(gameOverTxt2:getHeight()/2))

gameOver = Button.new(gameOverTxt1, gameOverTxt2)

snake = Shape.new()
snake:setLineStyle(5*scale, 0xff0000)
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

dot = Shape.new()
dot:setLineStyle(10*scale,0x00000ff)
dot:beginPath()
dot:moveTo(0,0)
dot:lineTo(0,0)
dot:endPath()
dot:setX(math.random(15,xRange-15))
dot:setY(math.random(15,(yRange*0.5)-15))

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

scoreTxt = TextField.new(nil, "Score: 0")
scoreTxt:setScale(2*scale)
scoreTxt:setPosition((xRange*0.8)-(scoreTxt:getWidth()*0.5), yRange*0.75)
stage:addChild(scoreTxt)

triangle1 = Shape.new()
triangle1:setLineStyle(4, 0x000000)
triangle1:beginPath()
triangle1:moveTo(0,0)
triangle1:lineTo(33*scale,25*scale)
triangle1:lineTo(0,50*scale)
triangle1:closePath()
triangle1:endPath()
triangle1:setPosition((xRange/2)-(triangle1:getWidth()/2), (yRange*0.3))

triangle2 = Shape.new()
triangle2:setLineStyle(4, 0x000000)
triangle2:setFillStyle(Shape.SOLID, 0xff00ff)
triangle2:beginPath()
triangle2:moveTo(0,0)
triangle2:lineTo(33*scale,25*scale)
triangle2:lineTo(0,50*scale)
triangle2:closePath()
triangle2:endPath()
triangle2:setPosition((xRange/2)-(triangle2:getWidth()/2), (yRange*0.3))

playBtn = Button.new(triangle1, triangle2)
stage:addChild(playBtn)

currentX = snakePointX
currentY = snakePointY
length = startLength
score = 0
a = 0
b = 0
c = 0
d = 0
e = 0
f = 0
u = 0
w = 0
starting = true
turn = 0
turnPosX = {}
turnPosY = {}
direction = {}
for k = 1, 100 do
	turnPosX[k] = 0
	turnPosY[k] = 0
	direction[k] = 0
end

function onUpdate()
	world:step(1/60,8,3)
	if snakeDirection == 1 then --down
		starting = false
		b=0
		c=0
		d=0
		
		currentX = currentX
		currentY = currentY+velocity
		
		if a == 0 then
			turn = turn + 1
			for  j = 1, turn do
				q = turn+1-j
				turnPosX[q+1] = turnPosX[q]
				turnPosY[q+1] = turnPosY[q]
				direction[q+1] = direction[q]
			end
			turnPosX[1] = currentX
			turnPosY[1] = currentY
			direction[1] = 1
		end
		a = a + 1
		
		if turn == 0 then 
			tailX = currentX
			tailY = currentY - length
		else
			lastDirection = direction[turn+1]
			distanceInX = 0
			distanceInY = 0
			for g = 1,turn-1 do
				if turnPosX[g] > turnPosX[g+1] then
					distanceInX = distanceInX + (turnPosX[g]-turnPosX[g+1])
				else 
					distanceInX = distanceInX + (turnPosX[g+1]-turnPosX[g])
				end
				if turnPosY[g] > turnPosY[g+1] then
					distanceInY = distanceInY + (turnPosY[g]-turnPosY[g+1])
				else
					distanceInY = distanceInY + (turnPosY[g+1]-turnPosY[g])
				end
			end
			distanceInX = distanceInX + (currentX-turnPosX[1])
			distanceInY = distanceInY + (currentY-turnPosY[1])
			afterTurnLength = length - (distanceInX + distanceInY)
			if lastDirection == 1 then
				tailX = turnPosX[turn]
				tailY = turnPosY[turn] - afterTurnLength
			elseif lastDirection == 2 then
				tailX = turnPosX[turn] - afterTurnLength
				tailY = turnPosY[turn]
			elseif lastDirection == 3 then
				tailX = turnPosX[turn]
				tailY = turnPosY[turn] + afterTurnLength
			elseif lastDirection == 4 then
				tailX = turnPosX[turn] + afterTurnLength
				tailY = turnPosY[turn]
			end
			if afterTurnLength <= 0 then 
				turnPosX[turn] = 0
				turnPosY[turn] = 0
				direction[turn+1] = 0
				turn = turn - 1
				
			end
		end
		snake:clear()
		snake:setLineStyle(5*scale, 0xff0000)
		snake:beginPath()
		snake:moveTo(currentX, currentY)
		for i = 1, turn do
			snake:lineTo(turnPosX[i],turnPosY[i])
		end
		snake:lineTo(tailX,tailY)
		snake:endPath()
	elseif snakeDirection == 2 then --right
		starting = false
		a=0
		c=0
		d=0
		
		currentX = currentX+velocity
		currentY = currentY
		
		if b == 0 then
			turn = turn + 1
			for  j = 1, turn do
				q = turn+1-j
				turnPosX[q+1] = turnPosX[q]
				turnPosY[q+1] = turnPosY[q]
				direction[q+1] = direction[q]
			end
			turnPosX[1] = currentX
			turnPosY[1] = currentY
			direction[1] = 2
		end
		b = b + 1
		
		if turn == 0 then 
			tailX = currentX - length
			tailY = currentY 
		else
			lastDirection = direction[turn+1]
			distanceInX = 0
			distanceInY = 0
			for g = 1,turn-1 do
				if turnPosX[g] > turnPosX[g+1] then
					distanceInX = distanceInX + (turnPosX[g]-turnPosX[g+1])
				else 
					distanceInX = distanceInX + (turnPosX[g+1]-turnPosX[g])
				end
				if turnPosY[g] > turnPosY[g+1] then
					distanceInY = distanceInY + (turnPosY[g]-turnPosY[g+1])
				else
					distanceInY = distanceInY + (turnPosY[g+1]-turnPosY[g])
				end
			end
			distanceInX = distanceInX + (currentX-turnPosX[1])
			distanceInY = distanceInY + (currentY-turnPosY[1])
			afterTurnLength = length - (distanceInX + distanceInY)
			if lastDirection == 1 then
				tailX = turnPosX[turn]
				tailY = turnPosY[turn] - afterTurnLength
			elseif lastDirection == 2 then
				tailX = turnPosX[turn] - afterTurnLength
				tailY = turnPosY[turn]
			elseif lastDirection == 3 then
				tailX = turnPosX[turn]
				tailY = turnPosY[turn] + afterTurnLength
			elseif lastDirection == 4 then
				tailX = turnPosX[turn] + afterTurnLength
				tailY = turnPosY[turn]
			end
			if afterTurnLength <= 0 then 
				turnPosX[turn] = 0
				turnPosY[turn] = 0
				direction[turn+1] = 0
				turn = turn - 1
				
			end
		end
		snake:clear()
		snake:setLineStyle(5*scale, 0xff0000)
		snake:beginPath()
		snake:moveTo(currentX, currentY)
		for i = 1, turn do
			snake:lineTo(turnPosX[i],turnPosY[i])
		end
		snake:lineTo(tailX,tailY)
		snake:endPath()
	elseif snakeDirection == 3 then --up
		if starting == true then
			c = 1
			starting = false
			direction[1] = 3
		end
		a=0
		b=0
		d=0
		
		currentX = currentX
		currentY = currentY-velocity
		
		if c == 0 then
			turn = turn + 1
			for  j = 1, turn do
				q = turn+1-j
				turnPosX[q+1] = turnPosX[q]
				turnPosY[q+1] = turnPosY[q]
				direction[q+1] = direction[q]
			end
			turnPosX[1] = currentX
			turnPosY[1] = currentY
			direction[1] = 3
		end
		c = c + 1
		if turn == 0 then 
			tailX = currentX 
			tailY = currentY + length
		else
			lastDirection = direction[turn+1]
			distanceInX = 0
			distanceInY = 0
			for g = 1,turn-1 do
				if turnPosX[g] > turnPosX[g+1] then
					distanceInX = distanceInX + (turnPosX[g]-turnPosX[g+1])
				else 
					distanceInX = distanceInX + (turnPosX[g+1]-turnPosX[g])
				end
				if turnPosY[g] > turnPosY[g+1] then
					distanceInY = distanceInY + (turnPosY[g]-turnPosY[g+1])
				else
					distanceInY = distanceInY + (turnPosY[g+1]-turnPosY[g])
				end
			end
			distanceInX = distanceInX + (turnPosX[1]-currentX)
			distanceInY = distanceInY + (turnPosY[1]-currentY)
			afterTurnLength = length - (distanceInX + distanceInY)
			if lastDirection == 1 then
				tailX = turnPosX[turn]
				tailY = turnPosY[turn] - afterTurnLength
			elseif lastDirection == 2 then
				tailX = turnPosX[turn] - afterTurnLength
				tailY = turnPosY[turn]
			elseif lastDirection == 3 then
				tailX = turnPosX[turn]
				tailY = turnPosY[turn] + afterTurnLength
			elseif lastDirection == 4 then
				tailX = turnPosX[turn] + afterTurnLength
				tailY = turnPosY[turn]
			end
			if afterTurnLength <= 0 then 
				turnPosX[turn] = 0
				turnPosY[turn] = 0
				direction[turn+1] = 0
				turn = turn - 1
				
			end
		end
		snake:clear()
		snake:setLineStyle(5*scale, 0xff0000)
		snake:beginPath()
		snake:moveTo(currentX, currentY)
		for i = 1, turn do
			snake:lineTo(turnPosX[i],turnPosY[i])
		end
		snake:lineTo(tailX,tailY)
		snake:endPath()
	elseif snakeDirection == 4 then --left
		starting = false
		a=0
		b=0
		c=0
		
		currentX = currentX-velocity
		currentY = currentY
		
		if d == 0 then
			turn = turn + 1
			for  j = 1, turn do
				q = turn+1-j
				turnPosX[q+1] = turnPosX[q]
				turnPosY[q+1] = turnPosY[q]
				direction[q+1] = direction[q]
			end
			turnPosX[1] = currentX
			turnPosY[1] = currentY
			direction[1] = 4
		end
		d = d + 1
		
		if turn == 0 then 
			tailX = currentX + length
			tailY = currentY 
		else
			lastDirection = direction[turn+1]
			distanceInX = 0
			distanceInY = 0
			for g = 1,turn-1 do
				if turnPosX[g] > turnPosX[g+1] then
					distanceInX = distanceInX + (turnPosX[g]-turnPosX[g+1])
				else 
					distanceInX = distanceInX + (turnPosX[g+1]-turnPosX[g])
				end
				if turnPosY[g] > turnPosY[g+1] then
					distanceInY = distanceInY + (turnPosY[g]-turnPosY[g+1])
				else
					distanceInY = distanceInY + (turnPosY[g+1]-turnPosY[g])
				end
			end
			distanceInX = distanceInX + (turnPosX[1]-currentX)
			distanceInY = distanceInY + (turnPosY[1]-currentY)
			afterTurnLength = length - (distanceInX + distanceInY)
			if lastDirection == 1 then
				tailX = turnPosX[turn]
				tailY = turnPosY[turn] - afterTurnLength
			elseif lastDirection == 2 then
				tailX = turnPosX[turn] - afterTurnLength
				tailY = turnPosY[turn]
			elseif lastDirection == 3 then
				tailX = turnPosX[turn]
				tailY = turnPosY[turn] + afterTurnLength
			elseif lastDirection == 4 then
				tailX = turnPosX[turn] + afterTurnLength
				tailY = turnPosY[turn]
			end
			if afterTurnLength <= 0 then 
				turnPosX[turn] = 0
				turnPosY[turn] = 0
				direction[turn+1] = 0
				turn = turn - 1
				
			end
		end
		snake:clear()
		snake:setLineStyle(5*scale, 0xff0000)
		snake:beginPath()
		snake:moveTo(currentX, currentY)
		for i = 1, turn do
			snake:lineTo(turnPosX[i],turnPosY[i])
		end
		snake:lineTo(tailX,tailY)
		snake:endPath()
	end
	
	dotX = dot:getX()
	dotY = dot:getY()
	if currentX-(5*scale) <= dotX and dotX <= currentX+(5*scale) then 
		if currentY-(5*scale) <= dotY and dotY <= currentY+(5*scale) then
			length = length + 25*scale
			score = score + 1
			scoreTxt:setText("Score: "..score)
			dot:clear()
			dot:setLineStyle(10*scale, 0x0000ff)
			dot:beginPath()
			dot:moveTo(0,0)
			dot:lineTo(0,0)
			dot:endPath()
			
			something = 0
			repeat
				dotX = math.random(15,xRange-15)
				dotY = math.random(15,(yRange*0.7)-15)
				if turn >= 1 then
					for o = 1, turn-1 do
						if dotX >= turnPosX[o]-4 and dotX <= turnPosX[o]+4 then
							if turnPosY[o] < turnPosY[o+1] then 
								if dotY >= turnPosY[o]-4 and dotY <=turnPosY[o+1]+4 then
									something = something + 1
								end
							else 
								if currentY <= turnPosY[o]+4 and currentY >=turnPosY[o+1]-4 then
									something = something + 1
								end
							end
						end
						if dotY >= turnPosY[o]-4 and dotY <= turnPosY[o]+4 then
							if dotX >= turnPosX[o]-4 and dotX <=turnPosX[o+1]+4 then
								something = something + 1
							end
						end
					end
					if dotX >= tailX-4 and dotX <= tailX+4 then
						if dotY >= turnPosY[turn] - 4 and dotY <= tailY + 4 then
							something = something + 1
						end
					end
					if dotY >= tailY-4 and dotY <= tailY+4 then
						if dotX >= turnPosX[turn] - 4 and dotX <= tailX + 4 then
							something = something + 1
						end
					end
				else
					if dotX >= currentX-4 and dotX < currentX+4 then
						if dotY > currentY then
							if dotY >= currentY-4 and dotY < tailY+4 then
								something = something + 1
							end
						else
							if dotY <= currentY-4 and dotY > tailY+4 then
								something = something + 1
							end
						end
					end
					if dotY >= currentY-4 and dotY < currentY+4 then
						if dotX > currentX then
							if dotX >= currentX-4 and dotX < tailX+4 then
								something = something + 1
							end
						else
							if dotX <= currentX-4 and dotX > tailX+4 then
								something = something + 1
							end
						end
					end
				end
				
				if something ~= 0 then
					complete = false
					something = 0
				else
					complete = true
					something = 0
				end
			until complete == true
			dot:setX(dotX)
			dot:setY(dotY)
		end
	end
	
	if currentX <= 5 or currentX >= xRange-5 then
		stage:addChild(gameOver)
		velocity = 0
	end
	if currentY <= 5 or currentY >= (yRange*0.7)-5 then 
		stage:addChild(gameOver)
		velocity = 0
	end
	if turn >= 1 then
		for o = 1, turn-1 do
			if currentX >= turnPosX[o]-4 and currentX <= turnPosX[o]+4 then
				if turnPosY[o] < turnPosY[o+1] then 
					if currentY >= turnPosY[o]-4 and currentY <=turnPosY[o+1]+4 then
						if a > 5 or b > 5 or c > 5 or d > 5 then
							stage:addChild(gameOver)
							velocity = 0
						end
					end
				else 
					if currentY <= turnPosY[o]+4 and currentY >=turnPosY[o+1]-4 then
						if a > 5 or b > 5 or c > 5 or d > 5 then
							stage:addChild(gameOver)
							velocity = 0
						end
					end
				end
			end
			if currentY >= turnPosY[o]-4 and currentY <= turnPosY[o]+4 then
				if currentX >= turnPosX[o]-4 and currentX <=turnPosX[o+1]+4 then
					if a > 5 or b > 5 or c > 5 or d > 5 then
						stage:addChild(gameOver)
						velocity = 0
					end
				end
			end
		end
		if currentX >= tailX-4 and currentX <= tailX+4 then
			if currentY >= turnPosY[turn] - 4 and currentY <= tailY + 4 then
				if a > 5 or b > 5 or c > 5 or d > 5 then
					stage:addChild(gameOver)
					velocity = 0
				end
			end
		end
		if currentY >= tailY-4 and currentY <= tailY+4 then
			if currentX >= turnPosX[turn] - 4 and currentX <= tailX + 4 then
				if a > 5 or b > 5 or c > 5 or d > 5 then
					stage:addChild(gameOver)
					velocity = 0
				end
			end
		end
	end
end

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

function reset()
	stage:removeChild(gameOver)
	
	currentX = snakePointX
	currentY = snakePointY
	length = startLength
	score = 0
	a = 0
	b = 0
	c = 0
	d = 0
	e = 0
	f = 0
	u = 0
	w = 0
	starting = true
	turn = 0
	turnPosX = {}
	turnPosY = {}
	direction = {}
	for k = 1, 100 do
		turnPosX[k] = 0
		turnPosY[k] = 0
		direction[k] = 0
	end
	
	snake:clear()
	snake:setLineStyle(5, 0xff0000)
	snakePointX = xRange/2
	snakePointY = yRange/2
	snake:beginPath()
	snake:moveTo(snakePointX, snakePointY)
	snake:lineTo(snakePointX, snakePointY+startLength)
	snake:closePath()
	snake:endPath()
	snakeDirection = 3
	
	scoreTxt:setText("Score: 0")
	
	velocity = 1*scale
end



function play()
	stage:removeChild(playBtn)
	stage:addChild(dot)
	
	leftBtn:addEventListener("click", left)
	rightBtn:addEventListener("click", right)
	upBtn:addEventListener("click", up)
	downBtn:addEventListener("click", down)
	
	stage:addEventListener(Event.ENTER_FRAME, onUpdate)
end

playBtn:addEventListener("click", play)

gameOver:addEventListener("click", reset)