extends Node

static func _get_project_settings(
	include:PackedStringArray,
	exclude:PackedStringArray,
)->PackedStringArray:
	var paths:PackedStringArray = []
	for path in include:
		var exlcude_valid:PackedStringArray = []
		for p in exclude: if( p.begins_with(path) ): exlcude_valid.append(p)
		var is_exclude=func(test): for p in exlcude_valid: if(test.begins_with(p)): return true
		
		for property:Dictionary in ProjectSettings.get_property_list():
			var property_name:String = property["name"]
			if(property_name.begins_with(path) && !is_exclude.call(property_name) ):
				paths.append(property_name)
	return paths
static func _save_project_settings(
	directory:String,
	paths_include:PackedStringArray,
	paths_exclude:PackedStringArray
)->int:
	var file:ConfigFile = ConfigFile.new()
	for path:String in _get_project_settings(paths_include, paths_exclude):
		var section:String = path.get_slice('/', 0)
		file.set_value(
			section,
			path.trim_prefix("%s/"%section),
			ProjectSettings.get(path)
		)
		print("saved <%s> as %10s"%[path, ProjectSettings.get(path)])
	return file.save(directory)
static func _load_project_settings(
	directory:String
)->int:
	var file:ConfigFile = ConfigFile.new()
	var error:int = file.load(directory)
	for section:String in file.get_sections():
		for key in file.get_section_keys(section):
			ProjectSettings.set_setting(
				"%s/%s"%[section, key],
				file.get_value(section, key)
			)
	return error
static func _reset_project_settings(
	paths_include:PackedStringArray,
	paths_exclude:PackedStringArray
)->void:
	for path:String in _get_project_settings(paths_include, paths_exclude):
		ProjectSettings.set_setting(path, ProjectSettings.property_get_revert(path))
		#print_debug(ProjectSettings.property_get_revert(path))

const DEFAULT_SETTINGS_DIRECTORY:String			= "user://settings.cfg"
const DEFAULT_SETTINGS_INCLUDE:PackedStringArray= ["custom/", "manager/", "input/"]
const DEFAULT_SETTINGS_EXCLUDE:PackedStringArray= ["input/ui_"]
const DEFAULT_GAMEFILE_DIRECTORY:String			= "user://savefile.cfg"
const DEFAULT_GAMEFILE_INCLUDE:PackedStringArray= ["game_data/"]
const DEFAULT_GAMEFILE_EXCLUDE:PackedStringArray= []

static func save_settings()->void:
	#assert(
		#ProjectSettings.has_setting("manager/settings/settings/directory") and 
		#ProjectSettings.has_setting("manager/settings/settings/include"),
		#"missing essential project settings"
	#)
	_save_project_settings(
		ProjectSettings.get_setting(
			"manager/settings/settings/directory",
			DEFAULT_SETTINGS_DIRECTORY),
		ProjectSettings.get_setting(
			"manager/settings/settings/include",
			DEFAULT_SETTINGS_INCLUDE),
		ProjectSettings.get_setting(
			"manager/settings/settings/exclude",
			DEFAULT_SETTINGS_EXCLUDE),
	)
static func save_game()->void:
	#assert(
		#ProjectSettings.has_setting("manager/settings/game_data/directory") and 
		#ProjectSettings.has_setting("manager/settings/game_data/include"),
		#"missing essential project settings"
	#)
	_save_project_settings(
		ProjectSettings.get_setting(
			"manager/settings/game_data/directory",
			DEFAULT_GAMEFILE_DIRECTORY),
		ProjectSettings.get_setting(
			"manager/settings/game_data/include",
			DEFAULT_GAMEFILE_INCLUDE),
		ProjectSettings.get_setting(
			"manager/settings/game_data/exclude",
			DEFAULT_GAMEFILE_EXCLUDE),
	)
static func load_settings()->void:
	#assert(
		#ProjectSettings.has_setting("manager/settings/settings/directory"),
		#"missing essential project settings"
	#)
	_load_project_settings(
		ProjectSettings.get_setting(
			"manager/settings/settings/directory",
			DEFAULT_SETTINGS_DIRECTORY)
	)
static func load_game()->void:
	#assert(
		#ProjectSettings.has_setting("manager/settings/game_data/directory"),
		#"missing essential project settings"
	#)
	_load_project_settings(
		ProjectSettings.get_setting(
			"manager/settings/game_data/directory",
			DEFAULT_GAMEFILE_DIRECTORY)
	)
static func reset_settings()->void:
	#assert(
		#ProjectSettings.has_setting("manager/settings/settings/include"),
		#"missing essential project settings"
	#)
	_reset_project_settings(
		ProjectSettings.get_setting(
			"manager/settings/settings/include",
			DEFAULT_SETTINGS_INCLUDE),
		ProjectSettings.get_setting(
			"manager/settings/settings/exclude",
			DEFAULT_SETTINGS_EXCLUDE),
	)
static func reset_game()->void:
	#assert(
		#ProjectSettings.has_setting("manager/settings/game_data/include"),
		#"missing essential project settings"
	#)
	_reset_project_settings(
		ProjectSettings.get_setting(
			"manager/settings/game_data/include",
			DEFAULT_GAMEFILE_INCLUDE),
		ProjectSettings.get_setting(
			"manager/settings/game_data/exclude",
			DEFAULT_GAMEFILE_EXCLUDE),
	)

func _init()->void:
	@warning_ignore("static_called_on_instance")
	load_settings()