
local up={}
local down={}

xRange = 320
yRange = 480

text = TextField.new(nil,"")
text:setScale(2)
text:setPosition(xRange/2, (yRange/4)*3)
stage:addChild(text)

for k=1, 7 do
	up[k] = Bitmap.new(Texture.new("Red.png"))
	down[k] = Bitmap.new(Texture.new("Black.png"))
end

a=0
local size=35
local shape={}
for j=1,7 do
	for i=1,6 do
		shape[i]= Shape.new()
		shape[i]:setLineStyle(3, 0x000000)
		shape[i]:setFillStyle(Shape.SOLID, 0xff0000, 0)
		shape[i]:beginPath()
		shape[i]:moveTo(0, 0)
		shape[i]:lineTo(size, 0)
		shape[i]:lineTo(size, size)
		shape[i]:lineTo(0, size)
		shape[i]:closePath()
		shape[i]:endPath()
		shape[i]:setX(a)
		shape[i]:setY(size*i)
		stage:addChild(shape[i])
	end
	a=a+size
end

local button = {}
local count=1
colomnSafe={}
grid = {}
for s = 1, 15 do
    grid[s] = {}
	colomnSafe[s] = true
    for t = 1, 14 do
        grid[s][t] = 0 
    end
end

function onClick(i)
	i=i+3
	if colomnSafe[i] == true then
		j=4
		coloured = true
		while coloured == true do
			if grid[i][j]==1 or grid[i][j]==2 then
				j = j+1
				coloured = true
			else
				coloured = false
			end
		end
		
		local shape2= Shape.new()
		shape2:setLineStyle(3, 0x000000)
		
		if count%2==1 then
			shape2:setFillStyle(Shape.SOLID, 0xff0000, 1)
			grid[i][j]=1
			--print(i-3,j-3,"red")
		end
		if count%2==0 then
			shape2:setFillStyle(Shape.SOLID, 0xffff00 , 1)
			grid[i][j]=2
			--print(i-3,j-3,"yellow")
		end
		
		shape2:beginPath()
		shape2:moveTo(0, 0)
		shape2:lineTo(size, 0)
		shape2:lineTo(size, size)
		shape2:lineTo(0, size)
		shape2:closePath()
		shape2:endPath()
		shape2:setX(size*(i-1-3))
		shape2:setY(size*(7-j+3))
		stage:addChild(shape2)
		
		--diagonal right up
		if grid[i][j] == 1 then 
			if grid[i+1][j+1]==1 then
				if grid[i+2][j+2]==1 then
					if grid[i+3][j+3]==1 then
						print("Red Wins")
						text:setText("Red Wins")
						text:setX(xRange/2-text:getWidth()/2)
					end
				end
			end
		end
		
		--horizontal right
		if grid[i][j] == 1 then 
			if grid[i+1][j]==1 then
				if grid[i+2][j]==1  then
					if grid[i+3][j]==1  then
						print("Red Wins")
						text:setText("Red Wins")
						text:setX(xRange/2-text:getWidth()/2)
					end
				end
			end
		end
		
		--diagonal right down
		if grid[i][j] == 1 then 
			if grid[i+1][j-1]==1 then
				if grid[i+2][j-2]==1  then
					if grid[i+3][j-3]==1  then
						print("Red Wins")
						text:setText("Red Wins")
						text:setX(xRange/2-text:getWidth()/2)
					end
				end
			end
		end
		
		--vertical down
		if grid[i][j] == 1 then 
			if grid[i][j-1]==1 then
				if grid[i][j-2]==1  then
					if grid[i][j-3]==1  then
						print("Red Wins")
						text:setText("Red Wins")
						text:setX(xRange/2-text:getWidth()/2)
					end
				end
			end
		end
		
		--diagonal left down
		if grid[i][j] == 1 then 
			if grid[i-1][j-1]==1 then
				if grid[i-2][j-2]==1  then
					if grid[i-3][j-3]==1  then
						print("Red Wins")
						text:setText("Red Wins")
						text:setX(xRange/2-text:getWidth()/2)
					end
				end
			end
		end
		
		--hoizontal left
		if grid[i][j] == 1 then 
			if grid[i-1][j]==1 then
				if grid[i-2][j]==1  then
					if grid[i-3][j]==1  then
						print("Red Wins")
						text:setText("Red Wins")
						text:setX(xRange/2-text:getWidth()/2)
					end
				end
			end
		end
		
		--diagonal left up
		if grid[i][j] == 1 then 
			if grid[i-1][j+1]==1 then
				if grid[i-2][j+2]==1  then
					if grid[i-3][j+3]==1  then
						print("Red Wins")
						text:setText("Red Wins")
						text:setX(xRange/2-text:getWidth()/2)
					end
				end
			end
		end
		
		--vertical up
		if grid[i][j] == 1 then 
			if grid[i][j+1]==1 then
				if grid[i][j+2]==1  then
					if grid[i][j+3]==1  then
						print("Red Wins")
						text:setText("Red Wins")
						text:setX(xRange/2-text:getWidth()/2)
					end
				end
			end
		end
		-------------------------------------------------------------------------------
		--diagonal right up
		if grid[i][j] == 2 then 
			if grid[i+1][j+1]==2 then
				if grid[i+2][j+2]==2 then
					if grid[i+3][j+3]==2 then
						print("Yellow Wins")
						text:setText("Yellow Wins")
						text:setX(xRange/2-text:getWidth()/2)
					end
				end
			end
		end
		
		--horizontal right
		if grid[i][j] == 2 then 
			if grid[i+1][j]==2 then
				if grid[i+2][j]==2  then
					if grid[i+3][j]==2  then
						print("Yellow Wins")
						text:setText("Yellow Wins")
						text:setX(xRange/2-text:getWidth()/2)
					end
				end
			end
		end
		
		--diagonal right down
		if grid[i][j] == 2 then 
			if grid[i+1][j-1]==2 then
				if grid[i+2][j-2]==2  then
					if grid[i+3][j-3]==2  then
						print("Yellow Wins")
						text:setText("Yellow Wins")
						text:setX(xRange/2-text:getWidth()/2)
					end
				end
			end
		end
		
		--vertical down
		if grid[i][j] == 2 then 
			if grid[i][j-1]==2 then
				if grid[i][j-2]==2  then
					if grid[i][j-3]==2  then
						print("Yellow Wins")
						text:setText("Yellow Wins")
						text:setX(xRange/2-text:getWidth()/2)
					end
				end
			end
		end
		
		--diagonal left down
		if grid[i][j] == 2 then 
			if grid[i-1][j-1]==2 then
				if grid[i-2][j-2]==2  then
					if grid[i-3][j-3]==2  then
						print("Yellow Wins")
						text:setText("Yellow Wins")
						text:setX(xRange/2-text:getWidth()/2)
					end
				end
			end
		end
		
		--hoizontal left
		if grid[i][j] == 2 then 
			if grid[i-1][j]==2 then
				if grid[i-2][j]==2  then
					if grid[i-3][j]==2  then
						print("Yellow Wins")
						text:setText("Yellow Wins")
						text:setX(xRange/2-text:getWidth()/2)
					end
				end
			end
		end
		
		--diagonal left up
		if grid[i][j] == 2 then 
			if grid[i-1][j+1]==2 then
				if grid[i-2][j+2]==2  then
					if grid[i-3][j+3]==2  then
						print("Yellow Wins, diagonal left up")
						text:setText("Yellow Wins")
						text:setX(xRange/2-text:getWidth()/2)
					end
				end
			end
		end
		
		--vertical up
		if grid[i][j] == 2 then 
			if grid[i][j+1]==2 then
				if grid[i][j+2]==2  then
					if grid[i][j+3]==2  then
						print("Yellow Wins")
						text:setText("Yellow Wins")
						text:setX(xRange/2-text:getWidth()/2)
					end
				end
			end
		end
		
		if j==9 then 
			colomnSafe[i]=false
			--print("Colomn "..(i-3).." unsafe")
		end
		count = count + 1
	end
end

for i=1,7 do
	button[i] = Button.new(up[i], down[i])
	button[i]:setPosition((i-1)*size, 7*size)
	button[i]:setScale(0.7)
	stage:addChild(button[i])
	stage:addChild(button[i])
	button[i]:addEventListener("click", 
	function()
		onClick(i)
	end)
end