extends Resource
class_name FocusInheritanceController

@export var mode:Control.FocusMode = Control.FOCUS_ALL
var focus_children:Array[Control]
var root:Node=null : set=set_root
func set_root(node:Node)->void:
	root = node
	focus_children = find_focus_children(root)
func find_focus_children(parent:Node)->Array[Control]:
	var res:Array[Control] = []
	for n:Node in parent.get_children(true):
		if(n is Control):
			if(n.get_focus_mode(mode)):res.append(n)
		if(n.get_child_count(true)>0):
			res.append_array( find_focus_children(n) )
	return res

func set_mode_children(focus_mode:Control.FocusMode)->void:
	for n:Control in focus_children:
		n.set_focus_mode(focus_mode)
