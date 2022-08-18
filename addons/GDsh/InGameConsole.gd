extends Control


## Control with console log and prompt
##
## You can use it for creating additional terminals, but usually it invokes by GDsh singleton
##
## @tutorial(How to use plugin): https://github.com/USBashka/console-godot-plugin


@onready var log = $VBox/Log
@onready var prompt = $VBox/HBox/Prompt


func _ready():
	prompt.grab_focus()

func send_command(text: String):
	log.text += "\n> [color=yellow]" + text + "[/color]"
	var list = text.strip_edges().split(" ")
	var command = list[0]
	var args = list.slice(1)
	var result = GDsh.call_command(command, args)
	if result:
		log.text += "\n" + str(result)

func _on_submit_pressed():
	prompt.grab_focus()
	if prompt.text:
		send_command(prompt.text)
		prompt.text = ""
	else:
		var TW = create_tween().set_trans(Tween.TRANS_SINE)
		TW.tween_property(prompt, "modulate", Color.RED, 0.1)
		TW.tween_property(prompt, "modulate", Color.WHITE, 0.1)
		TW.play()


func _on_prompt_gui_input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ENTER:
			get_tree().root.set_input_as_handled()
			_on_submit_pressed()


func _on_log_meta_clicked(meta: String):
	var protocol = meta.split("://")[0]
	match protocol:
		"command": send_command(meta.trim_prefix("command://"))
		_: OS.shell_open(meta)
