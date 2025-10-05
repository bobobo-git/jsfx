
full_path = debug.getinfo(1, "S").source:sub(2) --path of running lua
curr_dir = full_path:match("(.*[/\\])") --durrent directory of running lua
package.path = package.path .. ";" .. curr_dir .. "?.lua" --enhance searchpath for require
require("dub_functions") -- requirements

getnummidioutnumber()

index = full_path:match(".*_(.-)%.lua$")
t=index-1

track = reaper.GetTrack(0, t)
id=({reaper.get_action_context()})[4]

onoff= reaper.GetMediaTrackInfo_Value(track,"B_MUTE")
if onoff == 0 then
 reaper.SetMediaTrackInfo_Value(track, "B_MUTE",1)
 reaper.SetToggleCommandState(1,id,1)
 reaper.StuffMIDIMessage(mout,0x90 ,1, 0x7F)
 
else
 reaper.SetMediaTrackInfo_Value(track, "B_MUTE",0)
 reaper.SetToggleCommandState(1,id,0)
 reaper.StuffMIDIMessage(mout,0x90 ,1, 0x00)
end


