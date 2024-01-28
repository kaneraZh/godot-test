extends Button
class_name UiButton

enum MODE{FREE, SUBMENU, POPUP, CHANGE_SCENE, EMIT_SELECTION}
@export_enum('Free', 'Submenu', 'Pop up', 'Change Scene', 'emit object') var mode:int=1 : set=set_mode, get=get_mode
func get_mode()->int:return mode
func set_mode(v:int)->void:mode = v

#enum OBJ_TYPE{NULL, RESOURCE, NODE}
#var object_type:int = 0
#var object:Object = null : set=set_object,get=get_object
#func get_object()->Object:return object
#func set_object(v:Object)->void:
#	if(v is Node):		set_node(v)
#	elif(v is Resource):set_resource(v)
#	else:
#		object_type = OBJ_TYPE.NULL
#		object = null
@export var resource:Resource=null : get=get_resource, set=set_resource
func get_resource()->Resource: return resource
func set_resource(v:Resource)->void: resource = v
@export var node:Node=null : set=set_node
func get_node_()->Node:
	if(node): return node
	return resource.instantiate() if (resource is PackedScene) else resource.as_node()
func set_node(v:Node)->void:
	node = v

func _ready():
	connect(&"pressed", Callable(self, &'_on_press'))
#	if(mode != MODE.EMIT_SELECTION):
#		connect(&"pressed", Callable(self, &"emit_signal").bind(&"pressed") )

signal selected
func _on_press():
	match mode:
		MODE.SUBMENU:
			var menu:Control = get_node_()
			menu.connect(&'tree_exiting', Callable(self, &'grab_focus'), CONNECT_DEFERRED)
			get_parent().add_submenu(menu)
		MODE.POPUP:
			var menu:Control = get_node_()
			menu.connect(&'tree_exiting', Callable(self, &'grab_focus'), CONNECT_DEFERRED)
			get_parent().add_menu(menu)
		MODE.CHANGE_SCENE:
			get_tree().call_deferred(&"change_scene_to_packed", resource)
		MODE.EMIT_SELECTION:
			emit_signal(&'selected', get_resource())
