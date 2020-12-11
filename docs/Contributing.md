# Contribting

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
func _some_function(some_variable : float)-> void:
	pass
```
When writing functions in GdScript for Triside, make to follow these basics:
- At the begining of the function's name, put a _ , like `func _some_function()`.
- Always cast the function as something, like `func _some_function()->void`.
- If the function has parameters make sure to cast them as seomthing, like `func _some_function(parameter : float)->void`. 
