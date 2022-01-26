-- TRACK TYPES

TRACK_TYPES = {}

TRACK_TYPES.none = {
  name = "none",
  default_props=  {},
  bang = function (event) end
}

TRACK_TYPES.synth = {
  name = "synth",
  default_props=  {},
  bang = function (event) end
}

TRACK_TYPES.midi = {
  name = "midi",
  default_props = {
    channel = 1,
    device = 1
  },
  bang = function (event) end
}


function create_default_trig_props ()
  local props = {
    enabled = false,
    note = 60, -- of 88
    velocity = 100, -- of 127
    attack = 2, -- ms
    decay = 100, -- ms
    sustain = 100, -- percent of velocity?
    release = 2, -- ms
    probability = 1,
    send_reverb = 0,
    offset = 0, -- -/+ pulses (24ppqn?)
    retrig = false,
    retrig_length = 100, --ms ?
    retrig_speed = 16 -- 16ths
  }

  -- add the props for each possible track type
  for k,tt in pairs(TRACK_TYPES) do
    for prop,default in pairs(tt.default_props) do
      props[tt.name .. "_" .. prop] = default
    end
  end

  return props
end

-- Tracks

function create_track()
  local track = {
    name = "AAA",
    instrument = 1,
    scale = 1, -- from SCALES
    length = DEFAULT_TRACK_LENGTH, -- steps (*24 for ppqn)
    pulse = 0,
    lanes = {
      "note",
      "velocity"
    },
    default_trig_props = create_default_trig_props(),
    steps = {},
    -- events actually triggers the synth,
    -- it's a shorter table that gets looped each pulse
    -- multiple events for retrigs etc
    events = {}
  }

  -- Prepopulate all the steps

  for si=1, STEP_LIMIT do
    track.steps[si] = {}
  end

  return track
end

