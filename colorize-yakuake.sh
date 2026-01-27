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

R_HEX=${color_hex:0:2}
G_HEX=${color_hex:2:2}
B_HEX=${color_hex:4:2}

# Convert hex to decimal (0-255)
R=$((16#$R_HEX))
G=$((16#$G_HEX))
B=$((16#$B_HEX))

cat tabs.skin | sed -e "s/Skin=System.*/Skin=System $color/" > ../system-yakuake-${color_hex}/title/tabs.skin
cat tabs.skin | sed -e "s/Edited=.*/Edited=$(date +%D)/" > ../system-yakuake-${color_hex}/title/tabs.skin
cat tabs.skin | sed -e "s/red=.*/red=$R/" > ../system-yakuake-${color_hex}/title/tabs.skin
cat tabs.skin | sed -e "s/green=.*/green=$G/" > ../system-yakuake-${color_hex}/title/tabs.skin
cat tabs.skin | sed -e "s/blue=.*/blue=$B/" > ../system-yakuake-${color_hex}/title/tabs.skin
cat title.skin | sed -e "s/Skin=System.*/Skin=System $color/" > ../system-yakuake-${color_hex}/title/tabs.skin
cat title.skin | sed -e "s/Edited.*/Edited=$(date +%D)/" > ../system-yakuake-${color_hex}/title/tabs.skin
cat title.skin | sed -e "s/red=.*/red=$R/" > ../system-yakuake-${color_hex}/title/tabs.skin
cat title.skin | sed -e "s/green=.*/green=$G/" > ../system-yakuake-${color_hex}/title/tabs.skin
cat title.skin | sed -e "s/blue=.*/blue=$B/" > ../system-yakuake-${color_hex}/title/tabs.skin
