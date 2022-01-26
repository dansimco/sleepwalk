function screen_loop ()
  while true do
    if STATE.dirty then
      screen.ping()
      redraw()
    end
    clock.sleep(1 / 12)
  end
end

function redraw()
  screen.clear()
  if views[STATE.focus] then
    views[STATE.focus]()
  end
  screen.update()
end

--  views

views = {}

-- diagnostic

views.diagnostic = function ()
  current_line = 8
  screen.move(8, 8)
  screen.text(project.sequences[STATE.active_sequence].tracks[1].name)
  newline()
  screen.text("pulse " .. STATE.playheads[1])
  newline()
  local beat = math.floor(STATE.playheads[1] / PPQN / 4) + 1
  screen.text("beat " .. beat)
  newline()
  screen.text("length " .. project.sequences[STATE.active_sequence].tracks[1].length * PPQN)
end

function newline()
  current_line = current_line + 11
  screen.move(8, current_line)
end


--- track view

views.track = function ()
  local sequence = project.sequences[STATE.selected_sequence]
  local track = sequence.tracks[STATE.selected_track]
  screen.move(8,8)
  screen.text(get_selected_track_length())
end