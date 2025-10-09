function getnummidioutnumber()
--midi outputnanmedetection
i=0 retval=0 nameout="" mout=0
ii=reaper.GetNumMIDIOutputs()
while i<ii do
  retval, nameout = reaper.GetMIDIOutputNameNoAlias(i, "")
  if nameout=="MIDI Mix" then mout=i+16 break  end
  i= i + 1
end
return mout
 end
 getnummidioutnumber()
track = reaper.GetTrack(0, 7)
id=({reaper.get_action_context()})[4]

onoff= reaper.GetMediaTrackInfo_Value(track,"B_MUTE")
if onoff == 0 then
 reaper.SetMediaTrackInfo_Value(track, "B_MUTE",1)
 reaper.SetToggleCommandState(1,id,1)
 reaper.StuffMIDIMessage(mout,0x90 ,22, 0x7F)
 
else
 reaper.SetMediaTrackInfo_Value(track, "B_MUTE",0)
 reaper.SetToggleCommandState(1,id,0)
 reaper.StuffMIDIMessage(mout,0x90 ,22, 0x00)
end


