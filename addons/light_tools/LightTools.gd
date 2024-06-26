@tool
extends EditorPlugin

var light3d = load("res://addons/light_tools/LightColor.gd").new()
var old_icon: Texture
var theme: Theme

func _enter_tree():
	add_inspector_plugin(light3d)
	theme = get_editor_interface().get_base_control().theme
	if not theme: return
	if theme.has_icon("Light", "EditorIcons"):
		old_icon = theme.get_icon("Light", "EditorIcons")
	else:
		old_icon = theme.get_icon("Object", "EditorIcons")
	theme.set_icon("Light", "EditorIcons", load("res://addons/light_tools/Light.png"))


func _exit_tree():
	remove_inspector_plugin(light3d)
	theme.set_icon("Light", "EditorIcons", old_icon)


func get_plugin_icon():
	return load("res://addons/light_tools/ToolIcon.svg")


func get_plugin_name():
	return "Light Tools"
