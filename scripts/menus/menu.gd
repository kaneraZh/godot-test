extends VBoxContainer
class_name UiMenu

signal selected
@export var free_on_select:bool = false
@export var path:String="" : set=set_path#, get=get_path
var path_block:String = ""
func set_path(v:String):
	var path_blocks:PackedStringArray = v.rsplit('/')
	path_block = path_blocks[0]
	path = '/'.join(path_blocks)

@export var main_focus:Control = null
func _ready():
	var sig:StringName = &"selected"
	for c in get_children():
		if( c.has_signal(sig) ):
			c.connect(sig, Callable(self, &"emit_signal").bind(sig))
	
	if(free_on_select):
		connect(sig, Callable(self, &"queue_free"), CONNECT_DEFERRED)
	
	if(path):
		find_child(path_block).emit_signal(&"pressed")
	else:
		main_focus.grab_focus()

func add_menu(menu:Control)->void:
	set_visible(false)
	menu.connect(&'tree_exiting', Callable(self, &'set_visible').bind(true), CONNECT_DEFERRED)
	add_sibling(menu)
	menu.call_deferred(&'grab_focus')

func add_submenu(menu:Control)->void:
	add_sibling(menu)
	menu.call_deferred(&'grab_focus')
