# Apply a x-ressource theme to the tty                                2016-12-14
#
# .  _     |_ |_       |_ |_   _  __   _
# | (_) -- |  |  \/ -- |  | | (/_ ||| (/_
#                /
#_______________________________________________________________________________
#
# Set the directory where you usually set your themes:
THEMES="$HOME/.config/themes"
#
# Then run this script, with either one theme name as argument, or as is, to
# run it in an interactively filter.  You can set the filter to something like
# fzf, fzy, slmenu, pick, pick, selecta...
FILTER='iomenu'

# if no argument
if [ $# = 0 ]
then
	# interactively prompt for a color theme
	ls "$THEMES" | $FILTER
else
	# otherwise use the one from the command line argument
	printf %s $1
fi | xargs -i sed -rn '

# remove comment lines
/^[[:space:]]*!.*/ d

# remove empty lines
/^[[:space:]]*$/ d

# convert colors numbers from decimal to hexadecimal
s/color10/colorA/
s/color11/colorB/
s/color12/colorC/
s/color13/colorD/
s/color14/colorE/
s/color15/colorF/

# print escaped color names
s/.*\.color([0-9A-F])[[:space:]]*:[[:space:]]*#/\1/ p

' "$THEMES/{}" | while read color
do
	# TTY color escape codes
	printf '\033]P%s' "$color"
done

clear
