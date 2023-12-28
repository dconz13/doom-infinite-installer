#!/bin/bash
GZDoomPath=~/.var/app/org.zdoom.GZDoom/.config/gzdoom/
DoomInfiniteFile=DOOM_Infinite_
TempFolder=doom_temp

if [ $# -eq 0 ]; then
    >&2 echo "Provide the doom infinite download file"
    exit 1
fi

function install_doom {
    cd $(dirname "$1")
    if [[ $(basename "$1") == *.zip ]]; then
        unzip $(basename "$1") -d $TempFolder
        mv $TempFolder/*.pk3 $GZDoomPath
    else
        echo "Unsupported file extension."
    fi
}

function remove_previous_version {
    # Verify GZDoomPath exists
    if [ -d $GZDoomPath ]; then
        dir=$(pwd)
        cd $GZDoomPath
        # Remove previous file if it exists
        if [ -f $DoomInfiniteFile*.pk3 ]; then
            echo "Deleting older version of Doom Infinite..."
            rm -i $DoomInfiniteFile*.pk3
            echo "Deleted!"
        else
            echo "Older version of Doom Infinite does not exist. Installing new version..."
        fi
        cd $dir
    else
        echo "GZDoom path does not exist. Make sure to run GZDoom before running this script"
        exit 1
    fi
}

function delete_temp_folder {
    echo "Deleting temporary folder..."
    rm -rf $TempFolder
    echo "Done! Enjoy slaying demons!"
}

remove_previous_version
install_doom $1
delete_temp_folder