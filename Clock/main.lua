require "box2d"

width = application:getDeviceWidth()
height = application:getDeviceHeight()

world = b2.World.new(0,0)

timer = Timer.new(93,0)
timer2 = Timer.new(0,1)

leftUp = Bitmap.new(Texture.new("Buttons/left_up.png"))
leftDown = Bitmap.new(Texture.new("Buttons/left_down.png"))
rightUp = Bitmap.new(Texture.new("Buttons/right_up.png"))
rightDown = Bitmap.new(Texture.new("Buttons/right_down.png"))

left = Button.new(leftUp, leftDown)
right = Button.new(rightUp, rightDown)
left:setScale(0.3)
right:setScale(0.3)
left:setPosition(6,320)
right:setPosition(250,320)
stage:addChild(left)
stage:addChild(right)

local calibri =TTFont.new("calibril.ttf",20)

text = TextField.new(calibri, "")
text:setPosition(width/2,50)
text:setScale(1)
stage:addChild(text)

sillyClock = TextField.new(calibri, "")
sillyClock:setPosition(width/4,350)
sillyClock:setScale(1)
stage:addChild(sillyClock)

header = TextField.new(calibri, "")
header:setPosition(0,345)
header:setScale(1)
stage:addChild(header)

clockFace = Bitmap.new(Texture.new("clockface.jpg"))
clockFace:setScale(0.4)
clockFace:setPosition(40,70)
stage:addChild(clockFace)

hourHand = Shape.new()
hourHand:setLineStyle(5,0x0000ff)
hourHand:beginPath()
hourHand:moveTo(0,0)
hourHand:lineTo(0,50)
hourHand:closePath()
hourHand:endPath()
hourHand:setPosition(width/2,(height/2)-95)
stage:addChild(hourHand)

miniuteHand = Shape.new()
miniuteHand:setLineStyle(3,0xff0000)
miniuteHand:beginPath()
miniuteHand:moveTo(0,0)
miniuteHand:lineTo(0,60)
miniuteHand:closePath()
miniuteHand:endPath()
miniuteHand:setPosition(width/2,(height/2)-95)
stage:addChild(miniuteHand)

secondHand = Shape.new()
secondHand:setLineStyle(3,0x000000)
secondHand:beginPath()
secondHand:moveTo(0,0)
secondHand:lineTo(0,70)
secondHand:closePath()
secondHand:endPath()
secondHand:setPosition(width/2,(height/2)-95)
stage:addChild(secondHand)

percentageBox = Shape.new()
percentageBox:setLineStyle(3,0x000000)
percentageBox:beginPath()
percentageBox:moveTo(0,0)
percentageBox:lineTo(0,20)
percentageBox:lineTo(300,20)
percentageBox:lineTo(300,0)
percentageBox:closePath()
percentageBox:endPath()
percentageBox:setPosition(10,480-50)
stage:addChild(percentageBox)

sec1 = os.date("%S")
local bodyDef = {type = b2.DYNAMIC_BODY, position = {x=width/2, y=(height/2)-95}}
secondHand1 = world:createBody(bodyDef)
local shape = b2.EdgeShape.new()
local fixtureDef = {shape = shape, density = 1, restitution = 1, friction = 0}
secondHand1:createFixture(fixtureDef)
secondHand1:setSleepingAllowed(false)
secondHand1.secondHand=secondHand
stage:addChild(secondHand1.secondHand)
rotation1 = (((sec1/60)*360)+182)*math.pi/180
secondHand1:setAngle(rotation1)

hour1= os.date("%H")
miniute1 = os.date("%M")
sec1 = os.date("%S")

i=0

function onTimer()
	i=i+1
	text:setText(text:getText().."."..i)
	if i == 10 then
		i = 0
		text:setText(text:getText().."."..i)
	end
end



rotation11 = ((((sec1/60)*360)+180)*math.pi/180)+(6*math.pi/180)
if rotation11==9.4247779607694 then
	rotation11 = ((((0/60)*360)+180)*math.pi/180)
else
	rotation11 = rotation11
end
--print (rotation11)

k=0

function onUpdate()
	world:step(1/60, 8, 3)
	hour= os.date("%H")
	miniute = os.date("%M")
	sec = os.date("%S")
	year = os.date("%Y")
	month = os.date("%m")
	day = os.date("%A")
	mDate = os.date("%d")
	
	--hour = 0
	--miniute = 0
	--sec = 0

	function onTimer2()
	point = os.timer()
	function onNewUpdate()
		point1 = os.timer()-point
		l=0
		while point1 >= 1 do
			point1 =os.timer()-point - (1*l)
			l=l+1
		end
		newSec = sec+point1
		m=0
		while newSec >= 60 do
			m=m+1
			newSec = sec+point1 - (60*m)
		end
		newSec1 =  math.modf((newSec)*10)/10
		--text:setText(--[[day..mDate..month..year..]]hour..":"..miniute..":"..newSec1)
		--print (newSec1)
		
		--[[rotation1 = (((newSec1/60)*360)+180)*math.pi/180
		secondHand1:setAngle(rotation1)
		--secondHand1:setAngularVelocity(6*math.pi/180)
		secondHand1.secondHand:setPosition(secondHand1:getPosition())
		secondHand1.secondHand:setRotation(secondHand1:getAngle()*180/math.pi)]]
	end
	stage:addEventListener(Event.ENTER_FRAME, onNewUpdate)
	end
	
	if sec == sec1 +1 then
		print ("bob")
	end

	text:setText(--[[day..mDate..month..year..]]hour..":"..miniute..":"..sec)
	text:setPosition((width/2-text:getWidth()/2)-10,50)
	--text:setPosition(width/2-text:getWidth()/2,50)

	rotation1 = (((sec/60)*360)+180)*math.pi/180
	secondHand1:setAngle(rotation1)
	--secondHand1:setAngularVelocity(6*math.pi/180)
	secondHand1.secondHand:setPosition(secondHand1:getPosition())
	secondHand1.secondHand:setRotation(secondHand1:getAngle()*180/math.pi)

	if rotation1 == rotation11 then
		timer:start()
		timer2:start()
	end
	
	rotation1 = (((sec/60)*360)+180)*math.pi/180
	secondHand1:setAngle(rotation1)
	--secondHand1:setAngularVelocity(6*math.pi/180)
	secondHand1.secondHand:setPosition(secondHand1:getPosition())
	secondHand1.secondHand:setRotation(secondHand1:getAngle()*180/math.pi)
	
	--setting the rotation of the miniute hand
	rotation2 = (((miniute/60)*360)+180)+(sec/60)*6
	miniuteHand:setRotation(rotation2)

	--setting the rotation of the hour hand
	hourness = hour+1-1
	if hourness >=12 then
		rotation3 = ((((hour-12)/12)*360)+180)+(miniute/60)*30
	else
		rotation3 = (((hour/12)*360)+180)+(miniute/60)*30
	end
	hourHand:setRotation(rotation3)

	totalSec = hour*60*60+miniute*60+sec
	percentage = math.modf((totalSec*1/864)*1000)/1000
	
	degrees = (percentage/100)*360

	metricHour = percentage/10
	metricHours = math.modf(metricHour)
	metricMin = percentage*10-(metricHours*100)
	metricMins = math.modf(metricMin)
	metricSec = percentage*1000- (metricHours*10000)-(metricMins*100)
	metricSecs = math.modf(metricSec)
	
	completed = (percentage/100)*297 
	percentageBar = Shape.new()
	percentageBar:setFillStyle(Shape.SOLID,0x0000ff)
	percentageBar:setLineStyle(3,0x0000ff)
	percentageBar:beginPath()
	percentageBar:moveTo(0,0)	
	percentageBar:lineTo(0,14)
	percentageBar:lineTo(completed,14)
	percentageBar:lineTo(completed,0)
	percentageBar:closePath()	
	percentageBar:endPath()
	percentageBar:setPosition(13,480-47)
	stage:addChild(percentageBar)
	
	binH = hour
	nBinH = ""
	repeat
		binHM = binH%2
		binH = binH/2 
		if (binHM==1) then
			nBinH = nBinH.."1"
			binH = binH-0.5 
		elseif (binHM==0) then
			nBinH = nBinH.."0"
		end
	until (binH ==0)
	binaryH = string.reverse(nBinH)
	
	binM = miniute
	nBinM	= ""
	repeat
		binMM = binM%2
		binM = binM/2 
		if (binMM==1) then
			nBinM = nBinM.."1"
			binM = binM-0.5 
		elseif (binMM==0) then
			nBinM = nBinM.."0"
		end
	until (binM == 0)
	binaryM = string.reverse(nBinM)
	
	binS = sec
	nBinS = ""
	repeat
		binSM = binS%2
		binS = binS/2 
		if (binSM==1) then
			nBinS = nBinS.."1"
			binS = binS-0.5 
		elseif (binSM==0) then
			nBinS = nBinS.."0"
		end
	until (binS == 0)
	binaryS = string.reverse(nBinS)
	
	mcH2 = string.gsub(binaryH,"0",".")
	mcH = string.gsub(mcH2,"1","-")
	
	mcM2 = string.gsub(binaryM,"0",".")
	mcM = string.gsub(mcM2,"1","-")
	
	mcS2 = string.gsub(binaryS,"0",".")
	mcS = string.gsub(mcS2,"1","-")
	
	if position == 1 then
		sillyClock:setText(percentage.."%")
		sillyClock:setPosition((width/2-sillyClock:getWidth()/2)-10,360)
		header:setText("Percentage")
		header:setPosition((width/2-header:getWidth()/2)-10,335)
	elseif position == 2 then
		sillyClock:setText(metricHours..":"..metricMins..":"..metricSecs)
		sillyClock:setPosition((width/2-sillyClock:getWidth()/2)-10,360)
		header:setText("Metric")
		header:setPosition((width/2-header:getWidth()/2)-10,335)
	elseif position == 3 then
		sillyClock:setText(binaryH..":"..binaryM..":"..binaryS)
		sillyClock:setPosition((width/2-sillyClock:getWidth()/2)-10,360)
		header:setText("Binary")
		header:setPosition((width/2-header:getWidth()/2)-10,335)
	elseif position == 4 then
		RomanValueH = ""
		InputValueH = hour-1+1
		while (InputValueH > 9) do
			RomanValueH = RomanValueH.."X"
			InputValueH = InputValueH - 10
		end
		if (InputValueH > 8) then
			RomanValueH = RomanValueH.."XL"
			InputValueH = InputValueH - 9
		end
		while (InputValueH > 4) do
			RomanValueH = RomanValueH.."V"
			InputValueH = InputValueH - 5
		end
		while (InputValueH > 3) do
			RomanValueH = RomanValueH.."IV"
			InputValueH = InputValueH - 4
		end
		while (InputValueH > 0) do
			RomanValueH = RomanValueH.."I"
			InputValueH = InputValueH - 1
		end
		
		InputValueM = miniute+1-1
		RomanValueM = ""
		while (InputValueM > 49) do
			RomanValueM = RomanValueM.."L"
			InputValueM = InputValueM - 50
		end
		while (InputValueM > 39) do
			RomanValueM = RomanValueM.."XL"
			InputValueM	= InputValueM - 40
		end
		while (InputValueM > 9) do
			RomanValueM = RomanValueM.."X"
			InputValueM = InputValueM - 10
		end
		while (InputValueM > 8) do
			RomanValueM	= RomanValueM.."IX"
			InputValueM = InputValueM - 9
		end
		while (InputValueM > 4) do
			RomanValueM	= RomanValueM.."V"
			InputValueM = InputValueM - 5
		end
		while (InputValueM > 3) do
			RomanValueM = RomanValueM.."IV"
			InputValueM = InputValueM - 4
		end
		while (InputValueM > 0) do
			RomanValueM = RomanValueM.."I"
			InputValueM = InputValueM - 1
		end
		
		InputValueS = sec+1-1
		RomanValueS = ""
		while (InputValueS > 49) do
			RomanValueS = RomanValueS.."L"
			InputValueS = InputValueS - 50
		end
		while (InputValueS > 39) do
			RomanValueS = RomanValueS.."XL"
			InputValueS	= InputValueS - 40
		end
		while (InputValueS> 9) do
			RomanValueS	= RomanValueS.."X"
			InputValueS = InputValueS - 10
		end
		while (InputValueS > 8) do
			RomanValueS	= RomanValueS.."IX"
			InputValueS = InputValueS	- 9
		end
		while (InputValueS > 4) do
			RomanValueS	= RomanValueS.."V"
			InputValueS = InputValueS - 5
		end
		while (InputValueS > 3) do
			RomanValueS = RomanValueS.."IV"
			InputValueS = InputValueS - 4
		end
		while (InputValueS > 0) do
			RomanValueS= RomanValueS.."I"
			InputValueS = InputValueS - 1
		end
		sillyClock:setText(RomanValueH..":"..RomanValueM..":"..RomanValueS)
		sillyClock:setPosition((width/2-sillyClock:getWidth()/2)-10,360)
		header:setText("Roman Numerals")
		header:setPosition((width/2-header:getWidth()/2)-10,335)
	elseif position == 5 then
		sillyClock:setText(mcH.." / "..mcM.." / "..mcS)
		sillyClock:setPosition((width/2-sillyClock:getWidth()/2)-10,360)
		header:setText("Morse Code")
		header:setPosition((width/2-header:getWidth()/2)-10,335)
	elseif position == 6 then
		sillyClock:setText(degrees.."°")
		sillyClock:setPosition((width/2-sillyClock:getWidth()/2)-10,360)
		header:setText("Degrees")
		header:setPosition((width/2-header:getWidth()/2)-10,335)
	end
	
	timer2:addEventListener(Event.TIMER,onTimer2)
end

timer:addEventListener(Event.TIMER,onTimer)
stage:addEventListener(Event.ENTER_FRAME, onUpdate)

position = 1
function buttonLeft()
	position = position - 1
	if position == 0 then
		position = 6
	end	
	return position
end

function buttonRight()
	position = position + 1
	if position == 7 then
		position = 1
	end
	return position
end

left:addEventListener("click", buttonLeft)
right:addEventListener("click", buttonRight)
	