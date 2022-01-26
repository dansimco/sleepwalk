-- sleepwalk

--  @todo
--  * Do wraparound for negative offset on first trig
--  * Split out all state properties from project/sequences/tracks
--  * state > event_queues > events
--  * state > event_queues.pulse
--  * you could use the number wrap thing to maintain sequencer position between seqs
--  * change sequence on end of queue (polymetric even daaamn)

--  glossary
--  ========

--  Project / Sequence / Track / Trig -> Events

--  Step:       a numbered step in the quarter note sequence
--  Event:      an action definition, which is indexed to a 24ppqn pulse trig
--  Trig:       a step-numbered object which contains note property overrides
--  Props:      a table of everything an instrument needs to make a sound
--  Track:      represents a single instrument, provides the default value for trigs in a sequence
--  Lane:       a visible column which shows a particular note prop
--  Sequence:   a table of tracks, trig lists, and event queues

include("0_sleepwalk/lib/engine")
include("0_sleepwalk/lib/sequence")
include("0_sleepwalk/lib/track")
include("0_sleepwalk/lib/screen")
include("0_sleepwalk/lib/grid")
include("0_sleepwalk/lib/arc")
include("0_sleepwalk/lib/keys_encoders")
include("0_sleepwalk/lib/convenience")

STATE = {
  active_sequence = 1,
  selected_sequence = 1,
  selected_track = 1,
  selected_step = 1,
  bpm = 100,
  is_playing = true,
  focus = "diagnostic", -- project, project_settings, sequence, sequence_settings, track, trig, track_settings, trig_settings, diagnostic
  key_1_down = false,
  key_2_down = false,
  key_3_down = false,
  y_scroll = 0,
  x_scroll = 0,
  playheads = {},
  event_queues = {}
}

SCALES = {
  'chromatic',
  'dorian', -- etc
}

function create_project ()
  local project = {
    name = "My Project",
    active_sequence = 1,
    sequences = {}
  }
  return project
end