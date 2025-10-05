oldversion=""
version = reaper.GetExtState("recarms", "Version")
if version==nil or version=='' or version=="0" then
 version="1"
end
oldversion =version
function showinfo()
reaper.ClearConsole()
reaper.ShowConsoleMsg("actual version : "..oldversion.."\n1 recarm (un)mutes the fourth send on the track \n2 recarm (un)mutes first fx on the track \n3 recarm (un)mutes the items on the track \n4 recarm switches between lane 1 or 2 if exist on track\n9 recarm the track")
end

retval, version = reaper.GetUserInputs( "recarmversion", 1,"Version (0:info) 1 2 3 4 9", version )
if version=="0" then showinfo() version=oldversion end


if version==nil or version=='' or tonumber(version)<1 then
 version="1"
end
reaper.SetExtState("recarms", "Version",version,1)

