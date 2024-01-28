extends UiMenu
class_name UiFolder

@export_dir var folder:String
func set_folder(v:String)->void: folder = v
func build_directory(directory:String):
	for dir in DirAccess.get_directories_at(folder):
		var btn:UiButton = UiButton.new()
		var path:String = '%s/%s'%[directory, dir]
		if(dir.ends_with('.tscn')):
			btn.set_mode(UiButton.MODE.CHANGE_SCENE)
			btn.set_resource(load(path))
		if(dir.ends_with('.tres')):
			btn.set_mode(UiButton.MODE.EMIT_SELECTION)
			btn.set_resource(load(path))
		else:
			btn.set_mode(UiButton.MODE.SUBMENU)
			var menu:UiFolder = UiFolder.new()
			menu.set_folder(path)
			btn.set_node(menu)
func _ready():
	build_directory(folder)
	super()
