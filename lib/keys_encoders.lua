function key(n, x)
  print(n, x)

  if x == 1 then
    if n == 1 then
      STATE.key_1_down = true
    end
    if n == 2 then
      STATE.key_2_down = true
    end
    if n == 3 then
      STATE.key_3_down = true
    end
  end

  if x == 0 then
    if n == 1 then
      STATE.key_1_down = false
    end
    if n == 2 then
      STATE.key_2_down = false
    end
    if n == 3 then
      STATE.key_3_down = false
    end
  end

  if STATE.focus == "diagnostic" then
    if x == 0 and n == 3 then
      reset_all_playheads()
    end
  end

end