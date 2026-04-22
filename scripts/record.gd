extends Control

var effect: AudioEffectCapture
var player: AudioStreamPlayer2D

func _ready():
	var index = AudioServer.get_bus_index("Record")
	effect = AudioServer.get_bus_effect(index, 0) as AudioEffectCapture
	player = $AudioStreamPlayer

func _on_record_pressed():
	if $Record.text == "Stop":
		# Stop recording
		effect.clear_buffer()
		$Record.text = "Record"
		print("Recording stopped")
	else:
		# Start recording
		effect.clear_buffer()
		$Record.text = "Stop"
		print("Recording started...")

func _on_play_pressed():
	# Ambil buffer yang sudah direkam
	var frames = effect.get_frames_available()
	if frames == 0:
		print("Recording kosong!")
		return
	
	var data: PackedVector2Array = effect.get_buffer(frames)
	print("Frames captured: ", frames)
	# Di sini nanti data dikirim ke Whisper untuk di-transcribe
