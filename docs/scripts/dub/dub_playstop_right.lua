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

id=({reaper.get_action_context()})[4]
reaper.Main_OnCommand(40769,1)
onoff=reaper.GetPlayState(1)
if onoff == 0 then
  reaper.Main_OnCommand(40328,1)
  reaper.SetToggleCommandState(1,id,1)
  reaper.StuffMIDIMessage(mout,0x90 ,27, 0x7F)
else
  reaper.Main_OnCommand(40328,1)
  reaper.SetToggleCommandState(1,id,0)
  reaper.StuffMIDIMessage(mout,0x90 ,27, 0x00)
end

