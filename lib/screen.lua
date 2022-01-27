--  screen.lua
--  handles the norns screen redraw loop


-- clocked subroutine for screen redraw



function screen_loop ()
  while true do
    if STATE.dirty then
      screen.ping()
      redraw()
    end
    clock.sleep(1 / 12)
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
  glyph_string_small("000 --- 000 --- 11 -- 22 -- .99%", 0, 0)
  glyph_string_small("000 --- 000 --- 11 -- 22 -- .99%", 0, 7)
  glyph_string_small("000 --- 000 --- 11 -- 22 -- .99%", 0, 14)
  glyph_string_small("000 --- 000 --- 11 -- 22 -- .99%", 0, 21)
  screen.fill()
  screen.level(8)
  glyph_string_small("000 --- 000 --- 11 -- 22 -- .99%", 0, 28)
  screen.fill()
  screen.level(2)
  glyph_string_small("000 --- 000 --- 11 -- 22 -- .99%", 0, 35)
  glyph_string_small("000 --- 000 --- 11 -- 22 -- .99%", 0, 42)
  glyph_string_small("000 --- 000 --- 11 -- 22 -- .99%", 0, 49)
  glyph_string_small("000 --- 000 --- 11 -- 22 -- .99%", 0, 56)
  -- glyph_string_small("Track 01 - Crow", 0, 7)
  screen.fill()
  screen.level(2)
  -- glyph_string("ABCDEFGHIJKLMNOPQRST", 0, 20)

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

