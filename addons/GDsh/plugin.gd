@tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("GDsh", "res://addons/GDsh/GDsh.gd")


func _exit_tree():
	remove_autoload_singleton("GDsh")
