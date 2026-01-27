#!/bin/bash

## limitation: does not convert white to an rgb, source must have a color value

theme_path="$HOME/.var/app/org.kde.yakuake/data/yakuake/kns_skins/system-yakuake-template"

color=$1
color_hex=${1#\#}

cd ${theme_path} || return
mkdir ../system-yakuake-${color_hex}/{tabs,title} -p

for png in $(cat tabs.skin | grep png | cut -d= -f2); do
  if [[ $(basename $png) == "icon.png" ]]; then
    magick "icon.png" -fill "$color" +opaque "#000000" "../system-yakuake-${color_hex}/icon.png"
  else
    magick "tabs/$(basename $png)" -fill "$color" +opaque "#000000" "../system-yakuake-${color_hex}/tabs/$(basename $png)"
  fi
done

for png in $(cat title.skin | grep png | cut -d= -f2); do
  if [[ $(basename $png) == "icon.png" ]]; then
    magick "icon.png" -fill "$color" +opaque "#000000" "../system-yakuake-${color_hex}/icon.png"
  else
    magick "title/$(basename $png)" -fill "$color" +opaque "#000000" "../system-yakuake-${color_hex}/title/$(basename $png)"
  fi
done

## TODO: adjust .skin files

######

# magick icon.png -fill "$2" +opaque "#000000" icon2.png
# mv icon2 icon.png
#
# cd tabs
#
# tabs_files=("back_image.png"
#             "minus_over.png"
#             "plus_over.png"
#             "right_corner.png"
#             "selected_right.png"
#             "left_corner.png"
#             "minus_up.png"
#             "plus.png"
#             "selected_back.png"
#             "separator.png"
#             "minus_down.png"
#             "plus_down.png"
#             "plus_up.png"
#             "selected_left.png"
#             "unselected_back.png")
#
# for tab_file in "${tabs_files[@]}"; do
#     magick $tab_file -fill "$2" +opaque "#000000" $tab_file.new
#     mv $tab_file.new $tab_file
# done
#
# cd ../title
#
# title_files=("back.png"
#              "config_over.png"
#              "focus_down.png"
#              "focus_up.png"
#              "quit_down.png"
#              "quit_up.png"
#              "config_down.png"
#              "config_up.png"
#              "focus_over.png"
#              "left.png"
#              "quit_over.png"
#              "right.png")
#
# for title_file in "${title_files[@]}"; do
#     magick $title_file -fill "$2" +opaque "#000000" $title_file.new
#     mv $title_file.new $title_file
# done
# echo "A"
# cd ..
#
# color=$2
# color=${color#\#}
# R_HEX=${color:0:2}
# G_HEX=${color:2:2}
# B_HEX=${color:4:2}
#
# # Convert hex to decimal (0-255)
# R=$((16#$R_HEX))
# G=$((16#$G_HEX))
# B=$((16#$B_HEX))

# sed -i tabs.skin -e "s/Skin=System.*/Skin=System $color/"
# sed -i tabs.skin -e "s/Edited=.*/Edited=$(date +%D)/"
# sed -i tabs.skin -e "s/red=.*/red=$R/"
# sed -i tabs.skin -e "s/green=.*/green=$G/"
# sed -i tabs.skin -e "s/blue=.*/blue=$B/"
# sed -i title.skin -e "s/Skin=System.*/Skin=System $color/"
# sed -i title.skin -e "s/Edited.*/Edited=$(date +%D)/"
# sed -i title.skin -e "s/red=.*/red=$R/"
# sed -i title.skin -e "s/green=.*/green=$G/"
# sed -i title.skin -e "s/blue=.*/blue=$B/"

