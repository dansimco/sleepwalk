-- Sequences

function create_sequence ()
	local sequence = {
		length = DEFAULT_TRACK_LENGTH,
		polymetric = false,
		tracks = {
			create_track()
		}
	}
	return sequence
end


function reset_sequences ()
	for i=1, #STATE.event_queues do
		STATE.event_queues[i].pulse = 0
	end
end

function advance_sequence ()
	for i=1, #STATE.event_queues do
	  local queue = STATE.event_queues[i]
		STATE.playheads[i] = STATE.playheads[i] + 1
		local playhead_max = 0
		if project.sequences[STATE.active_sequence].polymetric then
		  playhead_max = project.sequences[STATE.active_sequence].length * PPQN
	  else
	    playhead_max = project.sequences[STATE.active_sequence].tracks[i].length * PPQN
    end
		if STATE.playheads[i] > playhead_max then
			STATE.playheads[i] = 1
		end
	end
end