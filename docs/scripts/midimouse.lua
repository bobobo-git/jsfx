-- REAPER Lua Script: Mousewheel to MIDI CC Controlpath via ReaImGui
-- Prereq.. ReaImGui has to be installed
-- gemini output, little srtirred by bobobo
-- Constants for MIDI Output
local MIDI_CHANNEL = 0  -- 0 channel 1 1, channel 2,..
local MIDI_CC_NUM = 22  -- MIDI CC-Befehl
local CC_VALUE = 64     -- Startvalue

-- Create ImGui Context
local ctx = reaper.ImGui_CreateContext('Mausrad zu MIDI CC')
local font = reaper.ImGui_CreateFont('sans-serif', 16)
reaper.ImGui_Attach(ctx, font)

-- Functions to send MIDI-data to where it belongs 1 for ControlPath
function send_midi_cc(cc_num, value)
    -- REAPER VST/Control Path MIDI-Injection
    -- 0xB0 is status-byte for CC on chan 1 (0xB0 + channel)
    local status = 0xB0 + MIDI_CHANNEL
    reaper.StuffMIDIMessage(1, status, cc_num, value)
end

-- Main Loop
function loop()
    reaper.ImGui_PushFont(ctx, font,10)
    
    -- Window
    local window_flags = reaper.ImGui_WindowFlags_NoScrollbar()
    local visible, open = reaper.ImGui_Begin(ctx, 'MIDI CC Painter', true, window_flags)
    
    if visible then
        -- 1. Draw a zone
        local width, height = 200, 100
        
        -- crreate an unvisible button
        local draw_list = reaper.ImGui_GetWindowDrawList(ctx)
        local start_x, start_y = reaper.ImGui_GetCursorScreenPos(ctx)
        
        -- Unvisible area
        reaper.ImGui_InvisibleButton(ctx, 'hover_zone', width, height)
        
        -- check hoverstate
        local is_hovered = reaper.ImGui_IsItemHovered(ctx)
        
        -- draw it
        
        reaper.ImGui_DrawList_AddText(draw_list, start_x + 20, start_y + 10, 0xFFDEAD, "Hover here\n and wheel")
        
        -- 2. check mouse logics
        if is_hovered then
            local wheel_y = reaper.ImGui_GetMouseWheel(ctx)
            
            if wheel_y ~= 0 then
                --adjust value
                CC_VALUE = CC_VALUE + math.floor(wheel_y * 2)
                
                -- limits check
                if CC_VALUE > 127 then CC_VALUE = 127 end
                if CC_VALUE < 0 then CC_VALUE = 0 end
                
                -- send MIDI CC
                send_midi_cc(MIDI_CC_NUM, CC_VALUE)
            end
        end
        
        -- show value
        reaper.ImGui_Text(ctx, string.format("CC %d Value: %d", MIDI_CC_NUM, CC_VALUE))
        
        reaper.ImGui_End(ctx)
    end
    
    reaper.ImGui_PopFont(ctx)
    
    -- loop til closed
    if open then
        reaper.defer(loop)
    end
end

-- start script
reaper.defer(loop)
