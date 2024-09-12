extends Node

const SAVE_PATH: String = "res://savegame.bin"
const SAVE_PASS: String = "password"

func get_file(is_write: bool):
	var save_game 
	var password: String = SAVE_PASS
	if OS.get_name() == "Android" or OS.get_name() == "iOS":
		password = OS.get_unique_id()
	if is_write:
		save_game = FileAccess.open_encrypted_with_pass(SAVE_PATH, FileAccess.WRITE, password)
	else: 
		if not FileAccess.file_exists(SAVE_PATH):
			return
		save_game = FileAccess.open_encrypted_with_pass(SAVE_PATH, FileAccess.READ, password)
	return save_game
	
func save_game():
	var save_game = get_file(true)
	var data: Dictionary = {
		"Plot": Global.Plot,
		"Harvests": Global.Harvests,
	}
	save_game.store_line(JSON.new().stringify(data))
	save_game.close()

func load_game():
	var save_game = get_file(false)
	if not save_game:
		return
	while not save_game.eof_reached():
		var test_json_conv = JSON.new()
		test_json_conv.parse(save_game.get_line())
		var current_line = test_json_conv.get_data()
		if current_line:
			Global.Plot = current_line["Plot"]
			Global.Harvests = current_line["Harvests"]
	save_game.close()
