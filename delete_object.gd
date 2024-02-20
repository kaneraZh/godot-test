@tool
extends Node
class_name PropertyTest

@export var arguments:String
@export var resource:Resource
@export var node:Node

var pot
func _get_property_list()->Array[Dictionary]:
	var properties:Array[Dictionary] = []
	properties.append({
		"name": "pot",
		"type": TYPE_STRING,
		"usage": PROPERTY_USAGE_DEFAULT,
		#"class_name": "",
		"hint": PROPERTY_HINT_DIR,
		"hint_string": "",
	})
	return properties
