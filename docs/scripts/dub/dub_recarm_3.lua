full_path = debug.getinfo(1, "S").source:sub(2) --path of running lua
curr_dir = full_path:match("(.*[/\\])") --durrent directory of running lua
package.path = package.path .. ";" .. curr_dir .. "?.lua" --enhance searchpath for require
require("dub_functions") -- requirements

getnummidioutnumber()

full_path = debug.getinfo(1, "S").source:sub(2)
index = full_path:match(".*_(.-)%.lua$")


--versions
--1 trackmute
--2 fxontrackmue
--3 trackitemmute

trackno=index-1-- track ofrecarmbutton, 0 is the first
mm=trackno*3+3 
fxcount=0 -- posotion of fx to switch, 0 is the first
trackfxno=2 -- track of the affected fx

--version=1
version=reaper.GetExtState("recarms","version")  -- wird aus ExtState geladen


if version=="1" then

-- track mute
track = reaper.GetTrack(0, trackno)
id=({reaper.get_action_context()})[4]


onoff=reaper.GetTrackSendInfo_Value(track, 0, 4, "B_MUTE")
if onoff == 1 then
 reaper.SetTrackSendInfo_Value(track, 0, 4, "B_MUTE",0)
 reaper.SetToggleCommandState(1,id,1)
 reaper.StuffMIDIMessage(mout,0x90 ,mm, 0x7F)
 
else
  reaper.SetTrackSendInfo_Value(track, 0, 4, "B_MUTE",1)
  reaper.SetToggleCommandState(1,id,0)
   reaper.StuffMIDIMessage(mout,0x90 ,mm, 0x00)
end
reaper.UpdateArrange()
end

if version=="2" then
--mute fxontrack
track = reaper.GetTrack(0, trackno)
trackfx=reaper.GetTrack(0, trackfxno)
id=({reaper.get_action_context()})[4]

onoff=reaper.GetExtState("recarms",trackno)
if onoff == "1" then
 reaper.TrackFX_SetOffline(trackfx, fxcount, false)
 reaper.SetExtState("recarms",trackno,"0",1)
 reaper.SetToggleCommandState(1,id,1)
 reaper.StuffMIDIMessage(mout,0x90 ,mm, 0x7F)
else
  reaper.TrackFX_SetOffline(trackfx, fxcount, true)
  reaper.SetExtState("recarms",trackno,"1",1)
  reaper.SetToggleCommandState(1,id,0)
  reaper.StuffMIDIMessage(mout,0x90 ,mm, 0x00)
end
reaper.UpdateArrange()
end


if version=="3" then

--trackitemmute


track = reaper.GetTrack(0, trackno)

id=({reaper.get_action_context()})[4]

onoff=reaper.GetExtState("recarms",trackno)
if onoff == "1" then
 for item_id = 0,  reaper.GetTrackNumMediaItems( track ) - 1 do
   item = reaper.GetTrackMediaItem( track, item_id  )
   iii= reaper.SetMediaItemInfo_Value(item, "B_MUTE",0)
 end
 reaper.SetExtState("recarms",trackno,"0",1)
 reaper.SetToggleCommandState(1,id,0)
 reaper.StuffMIDIMessage(mout,0x90 ,mm, 0x00)
 
else
 for item_id = 0,  reaper.GetTrackNumMediaItems( track ) - 1 do
   item = reaper.GetTrackMediaItem( track, item_id  )
   iii=reaper.SetMediaItemInfo_Value(item, "B_MUTE",1)
 end
  reaper.SetExtState("recarms",trackno,"1",1)
  reaper.SetToggleCommandState(1,id,1)
  reaper.StuffMIDIMessage(mout,0x90 ,mm, 0x7F)
end
reaper.UpdateArrange()
end

if version=="4" then
  -- select next lane on track .. to do
  id=({reaper.get_action_context()})[4]
  track = reaper.GetTrack(0, trackno)
  
  if reaper.GetMediaTrackInfo_Value(track, "C_LANEPLAYS:0", 1) ==1 then
      reaper.SetMediaTrackInfo_Value(track, "C_LANEPLAYS:1", 1)
      reaper.SetToggleCommandState(1,id,1)
    else
      reaper.SetMediaTrackInfo_Value(track, "C_LANEPLAYS:0", 1)
      reaper.SetToggleCommandState(1,id,0)
  end
  if reaper.GetMediaTrackInfo_Value(track, "I_NUMFIXEDLANES", 1)== 1 then
        reaper.SetToggleCommandState(1,id,0)
  end
end

