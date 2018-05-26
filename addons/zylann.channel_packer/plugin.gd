tool
extends EditorPlugin


const ChannelPacker = preload("dialog.tscn")
const LoadTextureDialog = preload("load_texture_dialog.gd")

var _channel_packer = null

const MENU_SHOW = 0


func _enter_tree():
	var editor_interface = get_editor_interface()
	var base_control = editor_interface.get_base_control()
	
	var load_texture_dialog = LoadTextureDialog.new()
	base_control.add_child(load_texture_dialog)

	_channel_packer = ChannelPacker.instance()
	base_control.add_child(_channel_packer)
	_channel_packer.call_deferred("set_load_texture_dialog", load_texture_dialog)
	# TODO This is an ugly workaround because of a Godot bug. Remove it once fixed!
	# See https://github.com/godotengine/godot/issues/17626
	_channel_packer.rect_min_size += Vector2(0, 100)

	# TODO Need Godot version including this merge https://github.com/godotengine/godot/pull/17576
#	var menu = PopupMenu.new()
#	menu.add_item("Show", MENU_SHOW)
#	menu.connect("id_pressed", self, "_on_menu_id_pressed")
#	add_tool_submenu_item("Channel packer", menu)
	var menu_button = MenuButton.new()
	menu_button.text = "Channel packer"
	menu_button.get_popup().add_item("Show", MENU_SHOW)
	menu_button.get_popup().connect("id_pressed", self, "_on_menu_id_pressed")
	add_control_to_container(CONTAINER_TOOLBAR, menu_button)


func _on_menu_id_pressed(id):
	if id == MENU_SHOW:
		_channel_packer.popup_centered_minsize()

