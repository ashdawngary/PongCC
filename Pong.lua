-- Pong for LUA
os.loadAPI("advapi")
instance = advapi.getMonitorInstance("monitor_5")
print(instance.getSize())
mst,mstc,msb,msbu = advapi.createScreen(instance)
paddle1 = 1
paddle2 = 1
function drawTitleScreen()
	mst,mstc,msb,msbu = advapi.drawRect(instance,mst,mstc,msb,msbu,5,5,20,10,colors.white,false)
	mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,10,7,"START",colors.green,colors.white)
	mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,1,1,"Pong By IntelX",colors.blue,colors.black)
	mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,10,20,"Click the White Button to Start!",colors.blue,colors.black)
	advapi.updateScreen(instance,mst,mstc,msb)
end
function drawScreen(p1,p2,bx,by)
	local length,width
	mst,mstc,msb,msbu = advapi.drawRect(instance,mst,mstc,msb,msbu,1,p1,3,p1+5,colors.white,false)
	mst,mstc,msb,msbu = advapi.drawRect(instance,mst,mstc,msb,msbu,length -3, p2, length, p2 + 5, colors.yellow,false)
	
	advapi.updateScreen(instance,mst,mstc,msb)
	return mst,mstc,msb,msbu
end
function waitforstart()
	
	while true do
	local event, side, x, y = os.pullEvent("monitor_touch")
	print(x.."  and "..y)
	if x  > 5 and x <= 20 then
		if y > 10 and y < 20 then
			print("Start was hit!")
			return 1
			
		end
	end
	end
	
	
end
parallel.waitForAny(drawTitleScreen,waitforstart)
