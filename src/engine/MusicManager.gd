# Inspired by https://github.com/Zylann/godot_music_manager/blob/master/addons/zylann.music_manager/music_manager.gd

extends Node
class_name MusicManager

"""
-80 = silent
0.0 = full volume
"""
var volume = -10.0

"""
Plays a stream without any fading.
"""
func play(stream):
	fade(stream, null, null, null)

"""
Play a stream with fading between previous streams.
stream (string or AudioStream): which stream to play next. If null, nothing will play next.
prev_duration (float): duration of previous tracks fade-out. If null, will stop directly.
next_duration (float): duration of next track fade-in. If null, will have full volume directly.
next_delay (float): delay in second before which the next track will start.
offset (int): sent to StreamPlayer.play()
"""
func fade(stream, prev_duration, next_duration=null, next_delay=0.0, offset=0):
	if typeof(stream) == TYPE_STRING:
		stream = load(stream)
	var next_track = null
	if stream != null:
		# Fade in next track
		next_track = _get_free_track(stream)
		_fade_in(next_track, next_duration, next_delay, stream, offset)
	# Fade out whatever was playing before
	for other_track in _tracks:
		if other_track != next_track and other_track.is_active():
			_fade_out(other_track, prev_duration)

func stop_all():
	for track in _tracks:
		track.stop()
		
class Track:
	var player = null
	var fade_speed = null
	var fade_value = 0.0
	var wait_time = null
	var play_offset = 0
	
	func is_active():
		return player.is_playing() or (wait_time != null)
	
	func stop():
		player.stop()
		fade_speed = null
		wait_time = null
		fade_value = 0.0


var _tracks = []
var _volume = 1.0


func _ready():
	set_process(true)


func _fade_in(track, duration, delay, stream, offset=0):
	if stream != null:
		track.player.set_stream(stream)
	
	track.wait_time = delay
	if delay == null:
		track.player.play(offset)
	else:
		track.play_offset = offset
	
	if duration == null or duration < 0.001:
		track.fade_speed = null
		track.fade_value = 1.0
		track.player.set_volume_db(_volume * volume)
	else:
		track.fade_speed = 1.0 / duration
		track.player.set_volume_db(track.fade_value * volume)


func _fade_out(track, duration):
	if track.wait_time != null:
		track.stop()
	else:
		if duration == null or duration < 0.001:
			track.fade_speed = null
			track.fade_value = 0.0
			track.player.set_volume_db(0.0 * volume)
		else:
			track.fade_speed = -1.0 / duration
			track.player.set_volume_db(track.fade_value * volume)


func _process(delta):
	for track in _tracks:
		# Update fading
		if track.fade_speed != null:
			var v = track.fade_value
			v += track.fade_speed * delta
			if v > 1.0 or v < 0.0:
				v = clamp(v, 0.0, 1.0)
				track.fade_speed = null
			track.fade_value = v
			track.player.set_volume_db(v * _volume * volume)
		# Update delay
		if track.wait_time != null:
			var t = track.wait_time
			t -= delta
			if t <= 0:
				track.wait_time = null
				track.player.play(track.play_offset)
			else:
				track.wait_time = t


func _get_free_track(stream):
	if stream != null:
		# First find a track that plays our song already
		for track in _tracks:
			if track.player.get_stream() == stream:
				return track
	# Otherwise, find a free track
	for track in _tracks:
		if track.is_active() == false:
			return track
	# If all else fails, create a new track
	var track = Track.new()
	track.player = AudioStreamPlayer.new()
	add_child(track.player)
	_tracks.append(track)
	return track
