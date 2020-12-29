# Weapon Files 
In Triside we use `.weapon` files to define the variables of a weapon like, damage or the name. The structure of `.weapon` files are as follow
```ini
[Weapon]
sType = "gun"
sDebugName = "basicgun1"
sName = "Basic Gun 1"
fFirerate = 1
fHoldFireRate = 0
iClipSize = 3
fReloadRate = 1.5
fDamage = 10
; Aiming
v3DefaultPos = Vector3(0, 0, 0)
v3AimPos = Vector3(-0.628, 0.289, 0.805)
fAimSpeed = 0.3
```

- `sType` - Is the type of weapon Triside will read it has. There are 2 types right now, `gun` and `melee`.
- `sName` - Is the name of the weaon, or common name. This is the name that will be displaied to the player.
- `sDebugName` - Is the name of the weapon used in scripts and by the Game.

### Type specific keys
- Gun
  - `fDirerate` - How fast you can fire the weapon. Used in scripts.
  - `fHoldFireRate` - How fast you can fire the weapon when you hold it down. Currently not used.
  - `iClipSize` - The clip size of the weapon.
  - `fReloadRate` - How fast the weapon reloads.
  - `fDamage` - The amount of damage the weapon does.
  - `v3DefaultPos` - The default postion of the weapon.
  - `v3AimPos` - The aim postion of the weapon.
  - `fAimSpeed` - How fast you want the weapon to aim.
- Melee
  - TBD

### How `.weapon` files interact with the game
  `.weapon` files interact with the game by overriding any defined variables in the editor. For example,<br>
Guns havs the variable `firerate`. If you do not define a weapon file for the weapon to read from, then it will defualt to what has been defined in the editor. <br>So if in the editor `firerate` is defined as `2` and we give it no weapon file to read from, then it will use what has been defined in the editor. Which is 2.
  
> Note: I might be changing theses in the future to `.object` or `.triside` files.
