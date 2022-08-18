extends Node


## GDsh console singleton
##
## This singleton used for executing, adding or deleteng commands
##
## @tutorial(How to use plugin): https://github.com/USBashka/console-godot-plugin



var commands = {
	"help": {
		"callable": help,
		"short_description": "Print the list of available commands",
		"description": "help <command> for specific help"
	},
	"gdfetch": {
		"callable": gdfetch,
		"short_description": "Display system information",
		"description": "Analogue of neofetch but shows Engine's stuff"
	}
}

func _ready():
	pass


## Calls command with given args if exists
func call_command(command: String, args: Array = []):
	if command in commands:
		return commands[command]["callable"].call(args)
	else:
		return "No such command \"%s\""%command


func get_version_info():
	return {"string": "0.0.2", "year": 2022}


func help(args: Array):
	var r = ""
	if args:
		for command in args:
			if command in commands:
				r += command + " [color=gray]" + commands[command]["short_description"] + "[/color]\n"
				r += "[color=gray]" + commands[command]["description"] + "[/color]\n"
			else:
				r += "No such command \"%s\""%command
	else:
		for command in commands:
			r += command + " [color=gray]" + commands[command]["short_description"] + "[/color]\n"
	return r

func gdfetch(args: Array):
	var r = ""
	var logo_mini = """     _    _
_  _| |__| |_  _
\\\\/          \\//
|  _        _  |
| (o)  ()  (o) |
l_    ____    _i
| |__/    \\__| |
\\_            _/
  `--______--`"""
	var username = OS.get_environment("USERNAME") + "@" + ProjectSettings.get_setting("application/config/name")
	var stats = {
		"OS": OS.get_name(),
		"Host": OS.get_model_name(),
		"Engine": "Godot {string} ({year})".format(Engine.get_version_info()),
		"Uptime": str(Time.get_ticks_msec()/1000) + " seconds",
		"Shell": "GDsh {string} ({year})".format(GDsh.get_version_info()),
		"Resolution": str(get_tree().root.get_visible_rect().size),
		"CPU": OS.get_processor_name(),
		"GPU": RenderingServer.get_video_adapter_name(),
		"Memory": String.humanize_size(OS.get_static_memory_usage()),
		"Video Memory": String.humanize_size(Performance.get_monitor(Performance.RENDER_VIDEO_MEM_USED)),
		
	}
	var logo_lines = logo_mini.split("\n")
	for line in stats.size() + 2:
		if line < logo_lines.size():
			r += "   [color=#478CBF]" + logo_lines[line].rpad(19) + "[/color]"
		else:
			r += " ".repeat(22)
		match line:
			0: r += "[b][color=#99aa99]" + username + "[/color][/b]"
			1: r += "-".repeat(username.length())
			_: r += "[b][color=#aaaa99]" + stats.keys()[line-2] + "[/color][/b]: " + stats[stats.keys()[line-2]]
		r += "\n"
	return r
