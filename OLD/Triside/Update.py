# This is a simple script that updates .gd files for Godot 4.0
# Note: Not everything can be changed, some have to be changed manually
# Read These:
# https://github.com/godotengine/godot/issues/20318
# https://github.com/godotengine/godot/issues/16863

import sys

rootWords = ["Spatial"]

# The syntax from Godot 4
newWords = ["Node3D"]

# The file you want to change
fileName = sys.argv[1]

with open(fileName) as main:
    with open("4.0_"+fileName, "w") as output:
        fileContents = main.read()
        for old in rootWords:
            for new in newWords:
                print(f"Found replace {old} replaced with {new}!" )
                fileContents = fileContents.replace(old, new)

        output.write(fileContents)

main.close()
output.close()
