<img align="left" width="64" height="64" src="icon.png">

# GDsh [![Made with Godot](https://img.shields.io/badge/Godot_4-2A5370?logo=godot%20engine&logoColor=white)](https://godotengine.org)
GDsh is simple console shell for adding to your game.

It allows you easily create new commands and have a *nice* interface.

![image](https://github.com/USBashka/console-godot-plugin/assets/51191280/5ae4c32e-5db8-4340-8b01-7dae00ebc037)


## Using
Add commands via `GDsh.add_command(name, function, short_desc, description)` method.
- `name` is command itself
- `function` is associated callable (right now **MUST** have `args` (`Array`) parameter)
- `short_desc` is description showed in commands list (optional)
- `description` is full description that showed when `help <name>` used (optional)
