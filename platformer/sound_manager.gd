extends Node

const SFX_POOL_SIZE := 10

var sfx_pool: Array[AudioStreamPlayer] = []
var bgm_player: AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_init_bgm_player()
	_init_sfx_pool()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _init_sfx_pool() -> void:
	for i in range(SFX_POOL_SIZE):
		var player = _new_player("SFX")
		add_child(player)
		sfx_pool.append(player)


func _init_bgm_player() -> void:
	bgm_player = _new_player("BGM")
	add_child(bgm_player)


func _new_player(bus: StringName) -> AudioStreamPlayer:
	var new_player := AudioStreamPlayer.new()
	new_player.bus = bus
	return new_player


func _get_available_sfx_player() -> AudioStreamPlayer:
	for player in sfx_pool:
		if !player.playing: return player
	
	var new_player = _new_player("SFX")
	add_child(new_player)
	sfx_pool.append(new_player)	
	
	return 


func play_bgm(stream: AudioStream, volume_db := 0.0) -> void:
	print("bgm_player:", bgm_player)
	if bgm_player.stream == stream and bgm_player.playing: return
	bgm_player.stream = stream
	bgm_player.volume_db = volume_db
	bgm_player.play()


func stop_bgm() -> void: 
	bgm_player.stop()


func play_sfx(stream: AudioStream, volume_db:= 0.0, pitch_scale:= 1.0) -> void:
	var player = _get_available_sfx_player()
	player.stream = stream
	player.volume_db = volume_db
	player.pitch_scale = pitch_scale
	player.play()


func set_bus_volume(bus: StringName, volume_db: float) -> void:
	var idx = AudioServer.get_bus_index(bus)
	if idx == -1: return
	AudioServer.set_bus_volume_db(idx, volume_db)


func mute_bus(bus: StringName, mute:= true) -> void:
	var idx = AudioServer.get_bus_index(bus)
	if idx == -1: return
	AudioServer.set_bus_mute(idx, mute)
	
