local g = grid.connect()

function grid_loop ()
  while true do
    if STATE.dirty then
      g:all(0)
      -- Diagnostic
      if STATE.focus == "diagnostic" then
        local beat = math.floor(STATE.playheads[1] / PPQN / 4) + 1
        g:led(1,beat,4)
      end
      g:refresh()
    end
    clock.sleep(1 / 12)
  end
end

