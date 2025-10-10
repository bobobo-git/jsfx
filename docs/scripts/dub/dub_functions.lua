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

function blink()

  i=0 -- 
  function wait(mseconds)
    local start = os.clock()
    m1=start
    m2=start+mseconds
    repeat until os.clock() > start + mseconds
  end

    for i = 1,  8 do
      led=3*i
      reaper.StuffMIDIMessage(mout,0x90 ,led, 0x7F)
      reaper.StuffMIDIMessage(mout,0x90 ,led-2, 0x7F)
      wait(0.05)
      reaper.StuffMIDIMessage(mout,0x90 ,led, 0x00)
      reaper.StuffMIDIMessage(mout,0x90 ,led-2, 0x00)
    end

    for i = 1,  8 do
      led=(8 - math.tointeger(i)+1)*3
      reaper.StuffMIDIMessage(mout,0x90 ,led, 0x7F)
      reaper.StuffMIDIMessage(mout,0x90 ,led-2, 0x7F)
      wait(0.05)
      reaper.StuffMIDIMessage(mout,0x90 ,led, 0x00)
      reaper.StuffMIDIMessage(mout,0x90 ,led-2, 0x00)

    end
end

getnummidioutnumber()

if reaper.GetExtState("recarms","Version")=='' then  -- wird aus ExtState geladen, wenn nichts da ist wird 9 gesetzt
  reaper.SetExtState("recarms", "Version","9",1)
end

 

