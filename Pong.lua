-- Pong for LUA
os.loadAPI("advapi")
instance = advapi.getMonitorInstance("monitor_0")
print(instance.getSize())
mst,mstc,msb,msbu = advapi.createScreen(instance)
paddle1 = 1
paddle2 = 1
function drawTitleScreen()
	mst,mstc,msb,msbu = advapi.drawRect(instance,mst,mstc,msb,msbu,10,5,5,20,colors.white,false)
	mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,1,1,"Pong By IntelX",colors.blue,colors.black)
	mst,mstc,msb,msbu = advapi.writeText(instance,mst,mstc,msb,msbu,20,22,"Click the White Button to Start!",colors.blue,colors.black)
	advapi.updateScreen(instance,mst,mstc,msb)
end
function drawScreen(p1,p2,bx,by)
	local length,width
	mst,mstc,msb,msbu = advapi.drawRect(instance,mst,mstc,msb,msbu,1,p1,3,p1+5,colors.white,false)
	mst,mstc,msb,msbu = advapi.drawRect(instance,mst,mstc,msb,msbu,length -3, p2, length, p2 + 5, colors.yellow,false)
	
	advapi.updateScreen(instance,mst,mstc,msb)
	return mst,mstc,msb,msbu
end