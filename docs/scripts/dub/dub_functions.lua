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