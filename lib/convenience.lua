-- convenience

function get_selected_sequence()
  return project.sequences[STATE.selected_sequence]
end

function get_selected_track()
  return get_selected_sequence().tracks[STATE.selected_track]
end

function get_track_length(i)
  length = 0
  if get_selected_sequence().polymetric then
    return get_selected_sequence().tracks[i].length
    else return get_selected_sequence().length
  end
end

function get_selected_track_length()
  return get_track_length(STATE.selected_track)
end
