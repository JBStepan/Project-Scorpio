# Contribting

## GDScript
### Way to write code
```gdscript
# Hello, im a comment
	
export var some_variable : int;

var some_variable : int;
```
When writing in GDScript for Triside, make sure to follow these basics:
- Use _'s as spaces.
- Always cast functions to somthing, void, float, etc.
- Always end a line with ; it makes it easier to read.
- Always cast variables with `var some_variable : int;` do the same when export a variable.
- When you write a comment, `# Hello, im a comment`, make sure you put a space between the `#` and the comment body.

### Writing functions
```gdscript
func _some_function(parameter : float)-> void:
	pass
```
When writing functions in GdScript for Triside, make to follow these basics:
- At the begining of the function's name, put a _ , like `func _some_function()`.
- Always cast the function as something, like `func _some_function()->void`.
- If the function has parameters make sure to cast them as seomthing, like `func _some_function(parameter : float)->void`. 

### Begining of files
```gdscript
#
# FILENAME
# ------------------
# Part of the Triside
# Copyright (c) 2020 JB Stepan. All Rights Reserved
# Licensed under License.txt. License.txt for more info.
#
# TODO: 
```
- FILENAME, is the place where you put the filename and extension 

## C#
### Way to write code
```cs
using Godot;
using System;

public class Player : Node
{
	// Hello im a comment
	
	[Export]
	int SomeVariable;
	
	int SomeVariable;
}
```
When writing in C# for Triside, make sure to follow these basics:
- Do not ever use spaces or _'s.
- When you write a comment, `// Hello, im a comment`, make sure you put a space between `//` and the comment body.
- Cast variables, no `var SomeVariable;` instead `int SomeVariable;`.
- When making variables always make sure the first letter of the variable is a capitol and every subsequent word in variable, like this `int SomeVariable;`.
- Follow the [Godot Docs](https://docs.godotengine.org/en/stable/getting_started/scripting/c_sharp/index.html?highlight=c%23).

### Writing Functions
```cs
using Godot;
using System;

public class Player : Node
{
	public void SomeFunction(float parameter)
	{
		GD.Print("Hello World")
	}
}
```
When writing functions in C# for Triside, make to follow these basics:
- Same with variables, always make sure the first letter of the variable is a capitol and every subsequent word in function.
- Do not ever use spaces or _'s.

### Comment things
GDScript
```gdscript
# NOTE(@YourName): Some Note
# TODO: Some ToDo
```
C#
```cs
// NOTE(@YOURNAME): Some Note
// TODO: Some ToDo
```
- TODO, todo's are something to do in future or something to fix.
- NOTE, notes are like sticky notes, you hate them but you gotta have them. Replace `@YOURNAME` with you Github Name e.g, `# NOTE(@tonymoooon543): Some note!`, just so we know whos making the notes

### Why?
All of this makes it easier to read and write
