extends Node

var data: Dictionary = {}

func _ready():
	var file = FileAccess.open("res://scripts/vocabs/vocabs.json", FileAccess.READ)
	if file == null:
		push_error("Gagal buka vocabs.json")
		return
	
	var json = JSON.new()
	var error = json.parse(file.get_as_text())
	
	if error != OK:
		push_error("JSON parse error: " + json.get_error_message())
		return
	
	var raw = json.get_data()
	
	for room in raw["rooms"]:
		for vocab in room["vocabs"]:
			vocab["room_id"] = room["id"]
			data[vocab["id"]] = vocab
	
	print("Total vocab loaded: ", data.size())

func get_vocab(vocab_id: String) -> Dictionary:
	if data.has(vocab_id):
		return data[vocab_id]
	push_warning("Vocab tidak ditemukan: '" + vocab_id + "' | Available: " + str(data.keys()))
	return {}
