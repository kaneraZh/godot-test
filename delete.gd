@tool
extends EditorScript

@export_enum("A", "B", "C") var mode:int = 0
func _get_property_list()->Array[Dictionary]:
	var properties:Array[Dictionary] = []
	#properties.append({
		#"name": "hammer_type",
		#"type": TYPE_INT,
		#"usage": property_usage, # See above assignment.
		#"hint": PROPERTY_HINT_ENUM,
		#"hint_string": "Wooden,Iron,Golden,Enchanted"
	#})
	return properties

func is_setting(name:String)->bool:
	for property in ProjectSettings.get_property_list():
		if(property["name"].begins_with(name)): return true
	return false

func _run()->void:
	#for property in ProjectSettings.get_property_list():
		#if(property["name"].begins_with("input")):
			#print(property["name"])
	#ProjectSettings.clear('manager/settings/game_data/directory')
	
	print( JSON.stringify( InputMap.get_property_list(), '\t', false) )
	
	#print( InputEventAction.new().get_class() 			== "InputEventAction")
	#print( InputEventJoypadButton.new().get_class() 	== "InputEventJoypadButton")
	#print( InputEventJoypadMotion.new().get_class() 	== "InputEventJoypadMotion")
	#print( InputEventMIDI.new().get_class() 			== "InputEventMIDI")
	#print( InputEventShortcut.new().get_class() 		== "InputEventShortcut")
	##print( InputEventFromWindow.new().get_class() 		== "InputEventFromWindow")
	#print( InputEventScreenDrag.new().get_class() 		== "InputEventScreenDrag")
	#print( InputEventScreenTouch.new().get_class() 		== "InputEventScreenTouch")
	##print( InputEventWithModifiers.new().get_class() 	== "InputEventWithModifiers")
	#print( InputEventKey.new().get_class() 				== "InputEventKey")
	##print( InputEventGesture.new().get_class() 		== "InputEventGesture")
	#print( InputEventMagnifyGesture.new().get_class() 	== "InputEventMagnifyGesture")
	#print( InputEventPanGesture.new().get_class() 		== "InputEventPanGesture")
	##print( InputEventMouse.new().get_class() 			== "InputEventMouse")
	#print( InputEventMouseButton.new().get_class() 		== "InputEventMouseButton")
	#print( InputEventMouseMotion.new().get_class() 		== "InputEventMouseMotion")
