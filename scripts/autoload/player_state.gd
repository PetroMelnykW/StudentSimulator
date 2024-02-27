extends Node

signal game_mode_changed(mode: GameMode)

enum GameMode {
	WALK,
	PANDA,
	PC_BUILDING,
	TRANSITION_CAMERA,
	MAIN_MENU,
	QUEST
}

var current_mode: GameMode = GameMode.WALK

func change_mode(new_mode: GameMode):
	current_mode = new_mode
	game_mode_changed.emit(current_mode)
