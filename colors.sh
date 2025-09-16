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


# NEW COLORS 20241101
#
# Nr #   R   G   B   H   S   B # Name
# FG # 250 250 250   0   0  98 # Daisy (White)
printf "\033]10;#FAFAFA\007"
# BG #  19  19  19   0   0   7 # -
printf "\033]11;#131313\007"

# Regular colors (0-7)

# Nr #   R   G   B   H   S   B # Name
#  0 #  61  61  61   0   0  24 # - (Black)
printf "\033]4;0;#3D3D3D\007"
#  1 # 186  19  61 345  90  73 # - (Red)
printf "\033]4;1;#BA133D\007"
#  2 #  61 186  19 105  90  73 # - (Green)
printf "\033]4;2;#3DBA13\007"
#  3 # 186 144  19  45  90  73 # - (Yellow)
printf "\033]4;3;#BA9013\007"
#  4 #  19  61 186 225  90  73 # - (Blue)
printf "\033]4;4;#133DBA\007"
#  5 # 144  19 186 285  90  73 # - (Magenta)
printf "\033]4;5;#9013BA\007"
#  6 #  19 186 144 165  90  73 # - (Cyan)
printf "\033]4;6;#13BA90\007"
#  7 # 186 186 186   0   0  73 # - (White)
printf "\033]4;7;#BABABA\007"

# Bright colors (8-15)

# Nr #   R   G   B   H   S   B # Name
#  8 # 122 122 122   0   0  48 # - (Black)
printf "\033]4;8;#363636\007"
#  9 # 250  25  81 345  90  98 # - (Red)
printf "\033]4;9;#FA1951\007"
# 10 #  81 250  25 105  90  98 # - (Green)
printf "\033]4;10;#51FA19\007"
# 11 # 250 194  25  45  90  98 # - (Yellow)
printf "\033]4;11;#FAC219\007"
# 12 #  25  81 250 225  90  98 # - (Blue)
printf "\033]4;12;#1951FA\007"
# 13 # 194  25 250 285  90  98 # - (Magenta)
printf "\033]4;13;#C219FA\007"
# 14 #  25 259 194 165  90  98 # - (Cyan)
printf "\033]4;14;#19FAC2\007"
# 15 # 250 250 250   0   0  98 # - (White)
printf "\033]4;15;#FAFAFA\007"

# BRIGHTER
#
# Nr #   R   G   B   H   S   B # Name
# FG # 250 250 250   0   0  98 # Daisy (White)
printf "\033]11;#FAFAFA\007"
# BG #  19  19  19   0   0   7 # -
printf "\033]10;#131313\007"

# Regular colors (0-7)

# Nr #   R   G   B   H   S   B # Name
#  0 #  61  61  61   0   0  24 # - (Black)
printf "\033]4;0;#3D3D3D\007"
#  1 # 186  19  61 345  90  73 # - (Red)
printf "\033]4;1;#E62E4D\007"
#  2 #  61 186  19 105  90  73 # - (Green)
printf "\033]4;2;#4DE62E\007"
#  3 # 186 144  19  45  90  73 # - (Yellow)
printf "\033]4;3;#E6C72E\007"
#  4 #  19  61 186 225  90  73 # - (Blue)
printf "\033]4;4;#2E4CE6\007"
#  5 # 144  19 186 285  90  73 # - (Magenta)
printf "\033]4;5;#C52DE3\007"
#  6 #  19 186 144 165  90  73 # - (Cyan)
printf "\033]4;6;#2EE6C7\007"
#  7 # 186 186 186   0   0  73 # - (White)
printf "\033]4;7;#BABABA\007"

# Bright colors (8-15)

# Nr #   R   G   B   H   S   B # Name
#  8 # 122 122 122   0   0  48 # - (Black)
printf "\033]4;8;#7A7A7A\007"
#  9 # 250  25  81 345  90  98 # - (Red)
printf "\033]4;9;#FF002B\007"
# 10 #  81 250  25 105  90  98 # - (Green)
printf "\033]4;10;#2BFF00\007"
# 11 # 250 194  25  45  90  98 # - (Yellow)
printf "\033]4;11;#FFd500\007"
# 12 #  25  81 250 225  90  98 # - (Blue)
printf "\033]4;12;#002AFF\007"
# 13 # 194  25 250 285  90  98 # - (Magenta)
printf "\033]4;13;#D400FF\007"
# 14 #  25 259 194 165  90  98 # - (Cyan)
printf "\033]4;14;#00FFC0\007"
# 15 # 250 250 250   0   0  98 # - (White)
printf "\033]4;15;#FAFAFA\007"

# TEsting again

# Nr #   R   G   B   H   S   B # Name
# FG # 250 250 250   0   0  98 # Daisy (White)
# FAFAFA # Daisy      (Foreground)
printf "\033]10;#FAFAFA\007"
# 171717 # Background
printf "\033]11;#171717\007"

# Nr #   R   G   B   H   S   B # Name
#  0 #  61  61  61   0   0  24 # - (Black)
printf "\033]4;0;#202124\007"
#  1 # 186  19  61 345  90  73 # - (Red)
printf "\033]4;1;#EA4335\007"
#  2 #  61 186  19 105  90  73 # - (Green)
printf "\033]4;2;#34A853\007"
#  3 # 186 144  19  45  90  73 # - (Yellow)
printf "\033]4;3;#FBBC04\007"
#  4 #  19  61 186 225  90  73 # - (Blue)
printf "\033]4;4;#4285F4\007"
#  5 # 144  19 186 285  90  73 # - (Magenta)
printf "\033]4;5;#A142F4\007"
#  6 #  19 186 144 165  90  73 # - (Cyan)
printf "\033]4;6;#24C1E0\007"
#  7 # 186 186 186   0   0  73 # - (White)
printf "\033]4;7;#FBFCF8\007"

# Bright colors (8-15)

# Nr #   R   G   B   H   S   B # Name
#  8 # 122 122 122   0   0  48 # - (Black)
printf "\033]4;8;#5F6368\007"
#  9 # 250  25  81 345  90  98 # - (Red)
printf "\033]4;9;#EA4335\007"
# 10 #  81 250  25 105  90  98 # - (Green)
printf "\033]4;10;#34A853\007"
# 11 # 250 194  25  45  90  98 # - (Yellow)
printf "\033]4;11;#FBBC05\007"
# 12 #  25  81 250 225  90  98 # - (Blue)
printf "\033]4;12;#4285F4\007"
# 13 # 194  25 250 285  90  98 # - (Magenta)
printf "\033]4;13;#A142F4\007"
# 14 #  25 259 194 165  90  98 # - (Cyan)
printf "\033]4;14;#24C1E0\007"
# 15 # 250 250 250   0   0  98 # - (White)
printf "\033]4;15;#FFFFFF\007"

