extends Area2D

@export var revitaVocab_ID: String = ""
var vocab: Dictionary = {}

func _ready():
	input_pickable = true
	if revitaVocab_ID != "":
		vocab = VocabManager.get_vocab(revitaVocab_ID)
	if vocab.is_empty():
		push_warning("Vocab tidak ditemukan: " + revitaVocab_ID)
	self.input_event.connect(_on_input_event)

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if vocab.is_empty():
				return
			#test
			print("Word: ", vocab["word"])
			print("Phonetic: ", vocab["phonetic"])
			print("Indonesian: ", vocab["indonesian"])
