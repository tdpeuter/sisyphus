# tdpeuter color schemes
# The goal is to offer light and dark theme that is easy on the eyes,
# whilst also being unique and defining.

###############################
# tdpeuter-light color scheme #
###############################

# 171717 # Foreground
# FAFAFA # Daisy (Background)

# Regular colors (0-7)

# 000000 # Black (0)
# 1
# 2
# 3
# 4
# 5
# 6
# 7

# Bright colors (8-15)

# 000000 # Black (8)
# 9
# 10
# 11
# 12
# 13
# 14
# 15

##############################
# tdpeuter-dark color scheme #
##############################

# FAFAFA # Daisy      (Foreground)
printf "\033]10;#FAFAFA\007"
# 171717 # Background
printf "\033]11;#171717\007"

# Regular colors (0-7)

# 242124 # Black                   0
printf "\033]4;0;#242124\007"
# B90E0A # Crimson    (Red)        1
printf "\033]4;1;#B90E0A\007"
# B2BC68 # Leafy      (Green)      2
printf "\033]4;2;#B2BC68\007"
# FFE135 # Banana     (Yellow)     3
printf "\033]4;3;#FFE135\007"
# 80A2BE # Icicle     (Blue)       4
printf "\033]4;4;#80A2BE\007"
# A45EE5 # Amethyst   (Magenta)    5
printf "\033]4;5;#A45EE5\007"
#        #            (Cyan)       6
printf "\033]4;6;#80A2BE\007"
# FBFCF8 # Pearl      (White)      7
printf "\033]4;7;#FBFCF8\007"

# Bright colors (8-15)

# 363636 # Grey-isch  (Black)      8
printf "\033]4;8;#363636\007"
# BC544B # Blush      (Red)        9
printf "\033]4;9;#BC544B\007"
# A6E3A1 # Lime       (Green)     10
printf "\033]4;10;#A6E3A1\007"
# FCF4A3 # Banana     (Yellow)    11
printf "\033]4;11;#FCF4A3\007"
# 74C7EC # Sapphire   (Blue)      12
printf "\033]4;12;#74C7EC\007"
# B4BEFE # Lavender   (Magenta)   13
# #CBA6F7
printf "\033]4;13;#B4BEFE\007"
#        #            (Cyan)      14
printf "\033]4;14;#74C7EC\007"
# FFFFFF # White                  15
printf "\033]4;15;#FFFFFF\007"

