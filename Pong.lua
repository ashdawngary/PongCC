-- Pong for LUA 82 wide 33 down
-- Mid is 41, 16
os.loadAPI("advapi")


instance = peripheral.find("monitor")
if (instance == nil)
	print("SoftError - No Monitor Hooked up.")
	return 404
end
print(instance.getSize())
mst,mstc,msb,msbu = advapi.createScreen(instance)
paddle1 = 1
paddle2 = 1
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
	local width,length = instance.getSize()
	mst,mstc,msb,msbu = advapi.drawRect(instance,mst,mstc,msb,msbu,1,p1,3,p1+5,colors.white,false)
	mst,mstc,msb,msbu = advapi.drawRect(instance,mst,mstc,msb,msbu,width -3, p2, width, p2 + 5, colors.yellow,false)
	
	
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



end
parallel.waitForAny(waitforstart,drawTitleScreen)
TitleScreenAnimation()
print("Passed Title Screen! Loading Code.")
parallel.waitForAny(coinFlipStart,CoinFlipBackground)
renderCoinFilp()
while true do
	

end