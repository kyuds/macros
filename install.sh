#!/bin/bash

echo "Creating 'scripts' directory in root..."
mkdir ~/scripts

for FILE in src/*; do
    echo "Installing $FILE"
    NAME="$(basename $FILE .sh)"
    cp $FILE ~/scripts/$NAME
    chmod +x ~/scripts/$NAME
done

echo "Adding 'scripts' directory to PATH..."
echo "export PATH=~/scripts:\$PATH" >> ~/.zprofile
echo "Done installation."

