extends Label

var time = 0

func _ready():
	self.modulate.a = 0

func newLabel(tx,timer):
	self.text = tx
	self.modulate.a = 1
	
	if timer != 0:
		time = timer
		timer = 0
		
func stopLabel():
	time = 0

func _process(delta):
	if time != 0 and time > 0:
		time -= delta
	else:
		if self.modulate.a != 0:
			self.modulate.a -= delta
