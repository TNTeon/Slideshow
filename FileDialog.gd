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
	
	
func openWindows(dir,displayCount):
	var imageList = []
	var imageNumber = 0
	
	await get_tree().create_timer(1.0).timeout
	get_viewport().gui_embed_subwindows = false
	var d = myWindow.instantiate()
	var dSprite = d.get_child(0)
	add_child(d)
	d.visible = true
	d.position = Vector2(800,800)
	d.size = Vector2(300,300)
	d.get_window().current_screen = displayCount
	
	var displayRes = DisplayServer.screen_get_size(displayCount)
	var directory = DirAccess.get_files_at(dir)
	
	for i in directory:
		if ".png" in i:
			imageList.append(i)
	
	dSprite.position = Vector2(displayRes.x/2,displayRes.y/2)
	d.mode = 3
	
	$Timer.start()
	
	while true:
		var image = Image.new()
		image.load(dir+"/"+imageList[imageNumber])
	
		var image_texture = ImageTexture.new()
		image_texture.set_image(image)
	
		dSprite.texture = image_texture
		
		dSprite.position = Vector2(displayRes.x/2,displayRes.y/2)
		dSprite.scale = Vector2(float(displayRes.x)/float(image_texture.get_width()),float(displayRes.y)/float(image_texture.get_height()))
		
		
		await get_tree().create_timer(30.0).timeout
		imageNumber +=1
