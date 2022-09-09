extends Node

#Generic sound system for playing sounds and music

var music_player
#var sound_player

var sound_players=[]
var sound_player_index=0
var max_sound_player_index=16

var current_music = null

var master_volume = 100
var sfx_volume = 100
var music_volume = 100

var music_volume_db = 0
var sfx_volume_db = 0

func _ready():
	# Create music and sound players
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Music"
	build_sfx_players()
	add_child(music_player)
	pause_mode = Node.PAUSE_MODE_PROCESS
	
	audio_test()

#	For whenver we want to conduct an audio test..
#	SuperQuickTimer.create_timer(self,"audio_test",[],2.5)


func build_sfx_players():
	#creates a bunch of sfx players and links them to the sfx players array for playing audio
	var sfx_player_count = 0
	while(sfx_player_count < max_sound_player_index):
		sfx_player_count += 1
		
		var sfx_player=AudioStreamPlayer.new()
		sfx_player.bus="SFX"
		sound_players.append(sfx_player)
		add_child(sfx_player)


func cycle_sound_players():
	#increments the sound player index by one;Cycles through the sound player index without going out of bounds
	sound_player_index+=1
	
	if(sound_player_index==max_sound_player_index):
		sound_player_index=0

var cd=0.05
func _process(delta):
	cd-=delta
	if(cd<0):
		refresh_sound_filter()
		cd=0.1

func audio_test():
	#For audio testing
#	SuperQuickTimer.create_timer(self,"play_sound",["Load",".wav"],0.1)
#	SuperQuickTimer.create_timer(self,"play_sound",["Load",".wav"],0.5)
#	SuperQuickTimer.create_timer(self,"play_sound",["Load",".wav"],1)
#	SuperQuickTimer.create_timer(self,"play_sound",["Load",".wav"],3)
#	SuperQuickTimer.create_timer(self,"play_sound",["Load",".wav"],1)
#	SoundSystem.set_music_volume(50)
	#QuickTimer.create_timer(SoundSystem,"play_music",["Battle", ".ogg"],2)
	#QuickTimer.create_timer(SoundSystem,"play_music",["Battle", ".ogg"],1)
	SoundSystem.play_music("loop",".ogg")
	#SoundSystem.set_music_volume(20)
#	QuickTimer.create_timer(SoundSystem,"play_music",["Battle", ".ogg"],1)
	
#	play_sound("Load",".wav")
#	play_sound("Notify",".wav")
#	play_sound("GenericClick",".ogg")



func set_master_volume(percentage:float):
	#Sets the master volume, which scales both SFX and music
	master_volume = percentage
	set_bus_volume(AudioServer.get_bus_index("Master"),master_volume)


func set_sfx_volume(percentage:float):
	#Sets the sfx volume, which scales individual sound effects
	sfx_volume=percentage
	set_bus_volume(AudioServer.get_bus_index("SFX"),sfx_volume)

func set_music_volume(percentage:float):
	#Sets the music volume, which scales music
	print(percentage)
	music_volume=percentage
	set_bus_volume(AudioServer.get_bus_index("Music"),music_volume)

func set_bus_volume(bus_index,percentage):
	#Generic bus volume setter; disables audio on that bus if volume percentage falls below 3 percent.
	AudioServer.set_bus_volume_db(bus_index, -60 + ((percentage / 100) * 60))
	
	if(percentage<3):
		AudioServer.set_bus_mute(bus_index,true)
	else:
		AudioServer.set_bus_mute(bus_index,false)


func play_music(file_name, file_type = ".ogg"):
	# Plays the given music file, of the given type ; Assumes it is in the music folder
	if(current_music == file_name): return
	music_volume = Settings.get_setting("music_volume")
#	print("playing music at "+str(music_volume))
	set_music_volume(music_volume)
	var ref = load("res://Framework/Audio/Music/" + file_name + file_type)
	current_music = file_name
	if(music_player.playing == true):
		Animator.linear_animate(music_player, "volume_db", [-60], 1)
		SuperQuickTimer.create_timer(self, "execute_play_music", [ref], 1.05)
	else:
		execute_play_music(ref)


func execute_play_music(ref):
	# Do not call directly, this is a timed portion of play music...
	if(music_player.playing == true):
		music_player.stop()
	Animator.linear_animate(music_player, "volume_db", music_volume_db, 1)
	music_player.stream = ref
	music_player.play()


var sounds=[]		#array of two element arrays


#first element stores sound ID
#second element stores recent uses

func sound_filter(input_string=""):
	var index=0
	while(index<sounds.size()):
		if(sounds[index][0]==input_string):
			if(sounds[index][1]>=3):
				return true
			else:
				sounds[index][1]+=1
				return false
		index+=1
	sounds.append([input_string,1])

func refresh_sound_filter():
	var index=0
	while(index<sounds.size()):
		sounds[index][1]-=1
		index+=1
	
	for sound in sounds:
		if(sound[1]<=0):
			remove_sound(sound[0])
func remove_sound(sound):
	var index=0
	while(index<sounds.size()):
		if(sounds[index][0]==sound):
			sounds.remove(index)
		index+=1



func play_sound(file_name, file_type = ".wav",multiplyer = 1.0):
	# Plays a single sound of the given file type, assumes it is in the SFX folder
	if(!file_name): 
		print("ERROR: Sound %s does not exist." % file_name)
		return 
	if(sound_filter(file_name)):return
	var ref = load("res://Framework/Audio/SFX/"+file_name+file_type)
	
	var sound_player=sound_players[sound_player_index]
	
	sound_player.volume_db = -60 + (((sfx_volume * multiplyer) / 100) * 60)
	sound_player.stream = ref
	sound_player.play()
	
	cycle_sound_players()
	
