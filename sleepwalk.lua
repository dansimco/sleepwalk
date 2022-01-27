include("0_sleepwalk/lib/main")

STEP_LIMIT = 256
DEFAULT_TRACK_LENGTH = 32
TRACK_LIMIT = 16
PPQN = 24

function init ()
  project = create_project()
  project.sequences[1] = create_sequence()
  reset_all_playheads()
  refresh_all_event_queues()
  STATE.dirty = true
  clock.run(engine_loop)
  clock.run(screen_loop)
  clock.run(grid_loop)
end

