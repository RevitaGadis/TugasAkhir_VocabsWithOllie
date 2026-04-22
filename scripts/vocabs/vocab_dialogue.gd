extends Control

@onready var label_word       : Label           = $PanelBox/VBoxContainer/LabelWord
@onready var label_phonetic   : Label           = $PanelBox/VBoxContainer/LabelPhonetic
@onready var label_indonesian : Label           = $PanelBox/VBoxContainer/LabelIndonesian
@onready var label_example    : RichTextLabel   = $PanelBox/VBoxContainer/LabelExample
@onready var panel_box        : PanelContainer  = $PanelBox


var current_vocab : Dictionary = {}

# ─── Warna panel per ruangan ──────────────────────────────────────────────
const ROOM_COLORS := {
	"bedroom":      Color("#A8C8E8"),
	"bathroom":     Color("#A8D8EA"),
	"living_room":  Color("#F9E4B7"),
	"kitchen":      Color("#C8E6C9"),
	"classroom":    Color("#FFCCBC"),
	"computer_lab": Color("#D1C4E9"),
}


func show_vocab(vocab_dict: Dictionary, room_id: String = "") -> void:
	current_vocab = vocab_dict
	_populate_ui(vocab_dict, room_id)
	show()                    # tampilkan panel

# ══════════════════════════════════════════════════════════════════════════
#  PRIVATE
# ══════════════════════════════════════════════════════════════════════════

func _ready() -> void:
	hide()   # mulai tersembunyi


func _populate_ui(v: Dictionary, room_id: String) -> void:
	# ── Teks ──────────────────────────────────────────────────────────────
	label_word.text       = v.get("word", "")
	label_phonetic.text   = v.get("phonetic", "")
	label_indonesian.text = v.get("indonesian", "")

	# Highlight kata vocab di contoh kalimat (bold)
	var word        : String = v.get("word", "")
	var example_raw : String = v.get("example", "")
	# Ganti huruf kapital/kecil dengan [b]word[/b]
	var example_bb  : String = example_raw.replace(
		word, "[b]" + word + "[/b]"
	).replace(
		word.to_lower(), "[b]" + word.to_lower() + "[/b]"
	)
	label_example.text = ""
	label_example.append_text("example :\n" + example_bb)

	# ── Warna panel sesuai ruangan ────────────────────────────────────────
	if room_id != "" and ROOM_COLORS.has(room_id):
		var style := StyleBoxFlat.new()
		style.bg_color        = ROOM_COLORS[room_id]
		style.corner_radius_top_left     = 12
		style.corner_radius_top_right    = 12
		style.corner_radius_bottom_left  = 12
		style.corner_radius_bottom_right = 12
		panel_box.add_theme_stylebox_override("panel", style)
