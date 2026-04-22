extends RichTextLabel

var completed_text := ""
var partial_text := ""

func _ready():
	custom_minimum_size.x = 400
	bbcode_enabled = true
	fit_content = true

func _process(_delta):
	update_text()

func update_text():
	text = completed_text + "[color=green]" + partial_text + "[/color]"

func _on_speech_to_text_transcribed_msg(is_partial, new_text):
	if is_partial:
		# Belum final, tampilkan hijau dulu
		partial_text = new_text
	else:
		# Kalimat sudah selesai, pindah ke completed
		if new_text != "":
			completed_text += new_text
			partial_text = ""
