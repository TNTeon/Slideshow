extends Node2D

var myWindow = preload("res://window.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$FileDialog.popup()
	


func _on_file_dialog_dir_selected(dir):
	var numberOfFolders = 0
	for file in DirAccess.get_directories_at(dir):
		openWindows(dir+"/"+file, numberOfFolders)
		numberOfFolders += 1
	$Timer.start()
	
	
func openWindows(dir,displayCount):
	
	await get_tree().create_timer(1.0).timeout
	get_viewport().gui_embed_subwindows = false
	var d = myWindow.instantiate()
	var dSprite = d.get_child(0)
	add_child(d)
	d.visible = true
	d.position = Vector2(800,800)
	d.size = Vector2(300,300)
