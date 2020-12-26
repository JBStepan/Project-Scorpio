# Weapon Files 
In Triside we use `.weapon` files to define the variables of a weapon like, damage or the name. The structure of `.weapon` files are as follow
```ini
[Weapon]
type = gun
name = "Basic Gun 1"
debugname = "basicgun1"
firerate = 1
holdfirerate = 0
clipsize = 3
reloadrate = 1.5
damage = 10
```

- `type` - Is the type of weapon Triside will read it has. There are 2 types right now, `gun` and `melee`.
- `name` - Is the name of the weaon, or common name. This is the name that will be displaied to the player.
- `debugname` - Is the name of the weapon used in scripts and by the Game.

### Type specific keys
- Gun
  - `firerate` - How fast you can fire the weapon. Used in scripts.
  - `holdfirerate` - How fast you can fire the weapon when you hold it down. Currently not used.
  - `clipsize` - The clip size of the weapon.
  - `reloadrate` - How fast the weapon reloads.
  - `damage` - The amount of damage the weapon does.
- Melee
  - TBD

### How `.weapon` files interact with the game
  `.weapon` files interact with the game by overriding any defined variables in the editor. For example,<br>
Guns havs the variable `firerate`. If you do not define a weapon file for the weapon to read from, then it will defualt to what has been defined in the editor. <br>So if in the editor `firerate` is defined as `2` and we give it no weapon file to read from, then it will use what has been defined in the editor. Which is 2.
  
> Note: I might be changing theses in the future to `.object` or `.triside` files.
