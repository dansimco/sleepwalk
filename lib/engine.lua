--  state

function refresh_all_event_queues ()
  STATE.event_queues = {}
  for i=1,#project.sequences[STATE.active_sequence].tracks do
    print("create event queue track " .. i)
    table.insert(STATE.event_queues, create_event_queue(i))
  end
end

function reset_all_playheads ()
  for i=1,#project.sequences[STATE.active_sequence].tracks do
    STATE.playheads[i] = 0
  end
end


function create_event_queue (i)
  --  uses track index of currently playing sequence to
  --  create event objects in a queue on the state object.
  --  this keeps the project object clean of state.

  local sequence = project.sequences[STATE.active_sequence]
  local track = project.sequences[STATE.active_sequence].tracks[i]

  local queue = {length = 0, events = {}}

  -- Set Queue Length
  local length = 0
  if sequence.polymetric then
    for i=1, #sequence.tracks do
      if sequence.tracks[i].length > length then
        length = sequence.tracks[i].length
      end
    end
  else
    length = sequence.length
  end

--  queue.length = length * PPQN

  -- Create Events from steps
  local steps = project.sequences[STATE.active_sequence].tracks[i].steps

  for i=1, length do
      -- create trig object with track defaults
      local trig = {}
      for k,v in pairs(track.default_trig_props) do
        trig[k] = v
      end
      -- override with trig props
      for k,v in pairs(track.steps[i]) do
        trig[k] = v
      end
      -- create events for trig
      if trig.enabled and trig.probability >= math.random() then
        local event_pulse = i * PPQN - PPQN + 1
        -- if no events table create one and insert the event
        if queue[event_pulse] == nil then
          queue[event_pulse] = {}
        end
        -- Push events into event table
        table.insert(queue[event_pulse], trig)
      end
    end

  return queue
end

function engine_loop ()
  while true do
    if STATE.is_playing then
      advance_sequence()
    end
    clock.sync(1/4/PPQN)
  end
end