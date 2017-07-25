-- Pong for LUA 82 wide 33 down
-- Mid is 41, 16
os.loadAPI("advapi")


instance = peripheral.find("monitor")
if (instance == nil) then
	print("SoftError - No Monitor Hooked up.")
	return 404
end
print(instance.getSize())
length,width = instance.getSize()
mst,mstc,msb,msbu = advapi.createScreen(instance)
paddle1 = 1
paddle2 = 1
ballx = -1
bally = -1
function dist(x1,y1,x2,y2)
	return math.sqrt(math.abs(x1-x2)^2 + math.abs(y2-y1)^2)
end
function drawTitleScreen()
	while true do
		mst,mstc,msb,msbu = advapi.drawRect(instance,mst,mstc,msb,msbu,5,5,20,10,colors.white,false)
		mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,10,7,"START",colors.green,colors.white)
		mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,1,1,"Pong By IntelX",colors.blue,colors.black)
		mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,10,20,"Click the White Button to Start!",colors.blue,colors.black)
		advapi.updateScreen(instance,mst,mstc,msb)
		sleep(0.2) -- throw a 5ps update OP
	end
end
function TitleScreenAnimation()
	for offset = 0,30 do
		print("Rendering Frame #"..offset);
		mst,mstc,msb,msbu = advapi.createScreen(instance)
		mst,mstc,msb,msbu = advapi.drawRect(instance,mst,mstc,msb,msbu,5-offset,5,20-offset,10,colors.white,false)
		mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,10-offset,7,"START",colors.white,colors.yellow)
		mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,1-offset,1,"Pong By IntelX",colors.yellow,colors.black)
		mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,10-offset,20,"Loading ...",colors.blue,colors.black)
		advapi.updateScreen(instance,mst,mstc,msb)
		sleep(0.03) -- Got that lit 30FPS o.o
		
	end
end
function drawScreen(p1,p2,bx,by)
	if (bx ==nil) then
		print("SOFTERROR: drawscreen recieved a nil ballX");
		return -1
	elseif (by == nil) then
		print("SOFTERROR: drawscreen recieved a nil ballY");
		return -1
	elseif (p1 == nil) then
		print("SOFTERROR: drawscreen recieved a nil paddle(P1)");
		return -1
	elseif (p2 == nil) then
		print("SOFTERROR: drawscreen recieved a nil paddle(P2)");
		return -1
	end
	
	local width,length = instance.getSize()
	mst,mstc,msb,msbu = advapi.drawRect(instance,mst,mstc,msb,msbu,1,p1,3,p1+5,colors.white,false)
	mst,mstc,msb,msbu = advapi.drawRect(instance,mst,mstc,msb,msbu,width -3, p2, width, p2 + 5, colors.yellow,false)
	mst,mstc,msb,msbu = advapi.writePixel(instance,mst,mstc,msb,msbu,bx,by,false,colors.red,false) -- draws 1 pixel of red at (bx,by)
	
	return mst,mstc,msb,msbu
end
function waitforstart()
	
	while true do
	local event, side, x, y = os.pullEvent("monitor_touch")
	print(x.."  and "..y)
	if (x  >= 5 and x <= 20) then
		if (y >= 5 and y <= 10) then
			print("Start was hit!")
			return 1
			
		end
	end
	end
	
	
end
function coinFlipStart()
	while true do -- Detect Coin Hit.
	
	local event, side, x, y = os.pullEvent("monitor_touch")
	print(x.."  and "..y)
	if (dist(x,y,41,16) < 5) then
			print("Coin was hit!")
			return 1
			
		end
	
	end
	
end
function CoinFlipBackground()
	mst,mstc,msb,msbu = advapi.createScreen(instance)
	paddle1 = 1
	paddle2 = 1
	target_paddle1 = math.random(1,20)
	target_paddle2 = math.random(1,20)
	text = {colors.red,colors.red,colors.lightBlue,colors.lightBlue,colors.yellow,colors.yellow,colors.orange,colors.orange}
	frame = 0
	while true do
		print("Rendering Frame #"..frame)
		mst,mstc,msb,msbu = advapi.createScreen(instance)
		drawScreen(paddle1,paddle2,0,0) -- no ball yet.
		if (paddle1  == target_paddle1) then -- extremely slick way to animate kek.
			target_paddle1 = math.random(1,20)
		else
			paddle1 = paddle1 +  (target_paddle1 - paddle1) / (math.abs(target_paddle1-paddle1))
		end
		if (paddle2  == target_paddle2) then -- extremely slick way to animate kek.
			target_paddle2 = math.random(1,20)
		else
			paddle2 =  paddle2 +(target_paddle2 - paddle2) / (math.abs(target_paddle2-paddle2))
		end
		mst,mstc,msb,msbu = advapi.drawRect(instance,mst,mstc,msb,msbu,43,14,47,18,colors.orange,false)
		mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,30,10,"Click on the Coin to CoinFlip!",text[(frame % 8)+1],colors.black)
		advapi.updateScreen(instance,mst,mstc,msb)
		frame = frame + 1
		sleep(0.1) -- Solid 10fps.
	end
end
function renderCoinFilp()
	turns = math.random(10,20)
	
	for f =0,turns do
		mst,mstc,msb,msbu = advapi.createScreen(instance)
		drawScreen(paddle1,paddle2,0,0) -- no ball yet.
		mst,mstc,msb,msbu = advapi.drawRect(instance,mst,mstc,msb,msbu,43,14,47,18,colors.orange,false)
		mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,45,16,tostring(f % 2),colors.black,colors.orange)
		advapi.updateScreen(instance,mst,mstc,msb)
		sleep(0.2)
	end
	
	ballx = 41
	bally = 16
	if (turns % 2 == 1) then
		velx = 1
	else
		velx = -1
	end
	vely = (math.random() * 2)-1
	print("CoinFlip Done.")
end
function clickHandler()
	local event, side, x, y = os.pullEvent("monitor_touch")
	if (y < paddle1) then
	paddle1 = math.max(paddle1-1,0)
	else
	paddle1 = math.min(paddle1+1,28)
	end
end
function playGame()
	
	while ((ballx > 2) and (ballx < 80) ) do
		mst,mstc,msb,msbu = advapi.createScreen(instance)	
		local width,length = instance.getSize()
		
		mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,39,1,"P",PongColors[(PROGRAM_FRAME % 5 )+ 1],colors.black)
		mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,40,1,"o",PongColors[((PROGRAM_FRAME+1) % 5 )+ 1],colors.black)
		mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,41,1,"n",PongColors[((PROGRAM_FRAME+2) % 5 )+ 1],colors.black)
		mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,42,1,"g",PongColors[((PROGRAM_FRAME+3) % 5 )+ 1],colors.black)
		mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,43,1,"!",PongColors[((PROGRAM_FRAME+4) % 5 )+ 1],colors.black)
		mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,39,2,"I",IntelColors[   (PROGRAM_FRAME % 5 )+ 1],colors.black)
		mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,40,2,"n",IntelColors[((PROGRAM_FRAME+1) % 5 )+ 1],colors.black)
		mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,41,2,"t",IntelColors[((PROGRAM_FRAME+2) % 5 )+ 1],colors.black)
		mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,42,2,"e",IntelColors[((PROGRAM_FRAME+3) % 5 )+ 1],colors.black)
		mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,43,2,"l",IntelColors[((PROGRAM_FRAME+4) % 5 )+ 1],colors.black)
		mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,43,2,"X",IntelColors[((PROGRAM_FRAME+5) % 5 )+ 1],colors.black)
		mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,39,4,colors.red,colors.black,"Match Point Worth"..(TAPS/10))
		mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,10,30,colors.white,colors.black,"Your Score"..PLAYERSCORE);
		mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,60,30,colors.yellow,colors.black,"Com Score"..COMSCORE);
		print msb[2]
		drawScreen(paddle1,paddle2,math.floor(ballx),math.floor(bally))
		if (bally  < 2) then
			vely = (math.random() * 1)
		end		
		if (bally > 32) then
			vely = (math.random() * -1)
		end
		if (math.floor(ballx) == 4) then
			-- check if bounced.
			if ((math.floor(bally) > paddle1) and (math.floor(bally) < (paddle1+5) )) then 
			 -- p1 just bounced.
			 velx = 1
			 vely = (math.random() * 2)-1
			end
			
		end
		
		if (math.floor(ballx) == width-4) then
			-- check if bounced.
			if ((math.floor(bally) > paddle2) and (math.floor(bally) < (paddle2+5))) then
			 -- p1 just bounced.
			 velx = -1
			 vely = (math.random() * 2)-1
			 
			end
		end
		
		
		
		
		paddle2 = paddle2 +(bally - (paddle2+3)) / (math.abs(bally -(paddle2+3))) -- Computer AI DONT TOUCH.
		ballx = ballx + velx
		bally = bally + vely
		sleep(0.1)
		PROGRAM_FRAME = PROGRAM_FRAME + 1
		TAPS = TAPS + 1
		advapi.updateScreen(instance,mst,mstc,msb)
	end
	print("Downtime.")
	if (ballx < 2) then
	COMSCORE = COMSCORE + TAPS / 10
	else
	PLAYERSCORE = PLAYERSCORE + TAPS/10
	end
	TAPS = 1
	sleep(3)
	print("Re-Entering game / Resetting ")
	ballx = 41
	bally = 16


end

parallel.waitForAny(waitforstart,drawTitleScreen)
TitleScreenAnimation()
print("Passed Title Screen! Loading Code.")
parallel.waitForAny(coinFlipStart,CoinFlipBackground)
renderCoinFilp()
PROGRAM_FRAME = 0
PongColors = {colors.red,colors.orange,colors.yellow,colors.green,colors.blue}
IntelColors = {colors.lightBlue,colors.white,colors.blue,colors.white,colors.lightBlue}
PLAYERSCORE = 0
COMSCORE = 0
TAPS = 0
while true do
parallel.waitForAny(clickHandler,playGame)	

end