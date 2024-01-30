extends Control

func _ready():
	$AnimationPlayer.play("loading")

func _on_video_stream_player_finished():
	get_tree().change_scene_to_file("res://scenes/ui/panda_os/desktop_panda_os.tscn")
