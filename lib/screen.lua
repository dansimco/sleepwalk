--  screen.lua
--  handles the norns screen redraw loop


-- clocked subroutine for screen redraw



function screen_loop ()
  while true do
    if STATE.dirty then
      redraw()
    end
    clock.sleep(1 / 6)
  end
end


--  the redraw function checks STATE.focus and looks for
--  a matching function in views

local views = {}
status_bar_title = ""

function lns(n)
  local line_height = 12
  local leading = 2
  return (line_height + leading) * n - leading -- flush to top
end

function redraw()
  screen.clear()
  screen.aa(0)
  screen.font_face(1)
  screen.font_size(8)
  screen.level(4)
  if views[STATE.focus] then
    views[STATE.focus]()
  end
  screen.move(20, 20)
  screen.clear()

  screen.level(2)
  screen.fill()

  for i=0,3 do
    l = " "
    if i == 3 then
      screen.level(10)
      l = ">"
    else
      screen.level(4)
    end
    glyph_string_small(l .. "TRACK ".. i+1 ..": D# DORIAN      130bpm", 0, i*8 + 1)
    screen.fill()
    screen.level(16)
    glyph_string("slyypwalk 2022", 4, 45)

    gx, gy = glf("test", 40, 32)
    glf("test", 40+gx, 32+gy)

    screen.fill()
  end

  screen.fill()
  screen.level(2)

  screen.update()
end


--  visual components

local scroll_view = function (x, y, direction, smooth)
  -- direction 0 = updown, 1 = leftright
  -- smooth = per pixel scroll, not smooth = per line scroll

  local v = {}

  v.sv_x = x
  v.sv_y = y
  v.direction = direction
  v.scroll_position = 0

  function v:set_scroll_position() end
  function v:scroll_fwd() end
  function v:scroll_bwd() end
  function v:page_fwd() end
  function v:page_bwd() end

  return v
end

local tracker_table = function (x, y)
  local v = scroll_view(x, y, 1)

  function v:track()

  end

  return v
end


--  views

--  diagnostic view. for dev debugging

views.diagnostic = function ()
  status_bar_title = "debug"
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


--  track view

views.track = function ()
  local sequence = project.sequences[STATE.selected_sequence]
  local track = sequence.tracks[STATE.selected_track]
  screen.move(8,8)
  screen.text(get_selected_track_length())
end

