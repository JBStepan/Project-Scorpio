# This is a simple script that updates .gd files for Godot 4.0
rootWords = ["Spatial"]

# The syntax from Godot 4
newWords = ["Node3D"]

# The file you want to change
fileName = "File.gd"

with open(fileName) as main:
    with open("4."+fileName, "w") as output:
        fileContents = main.read()
        for old in rootWords:
            for new in newWords:
                fileContents = fileContents.replace(old, new)

        output.write(fileContents)

main.close()
output.close()
