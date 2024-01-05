extends Node2D

var myWindow = preload("res://window.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$FileDialog.popup()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if $Timer.paused:
			$Timer.paused = false
		else:
			$Timer.paused = true
	
	if Input.is_action_just_pressed("ui_right"):
		$Timer.wait_time -= 1
	if Input.is_action_just_pressed("ui_left"):
		$Timer.wait_time += 1
	


func _on_file_dialog_dir_selected(dir):
	var numberOfFolders = 1
	get_window().size = Vector2(200,200)
	for file in DirAccess.get_directories_at(dir):
		openWindows(dir+"/"+file, numberOfFolders)
		numberOfFolders += 1
	$Timer.start()
	
	
func openWindows(dir,displayCount):
	
	await get_tree().create_timer(1.0).timeout
	get_viewport().gui_embed_subwindows = false
	var d = myWindow.instantiate()
	
	d.setVariables(displayCount,dir)
	
	var dSprite = d.get_child(0)
	add_child(d)
	
	d.visible = true
	d.size = Vector2(640,480)

