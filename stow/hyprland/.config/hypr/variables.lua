local M = {}

-- SHIFT CAPS CTRL/CONTROL ALT MOD2 MOD3 SUPER/WIN/LOGO/MOD4 MOD5
M.flag = "Super"

M.LMB   = "mouse:272"
M.RMB   = "mouse:273"
M.MMB   = "mouse:274"

M.left  = "h"
M.down  = "j"
M.up    = "k"
M.right = "l"

M.ws = {
    ids =  { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",    "11",    "12" },
    keys = { "1", "2", "3", "4", "5", "6", "7", "8", "9",  "0", "Minus", "Equal" },
}

M.term  = "foot"
M.menu  = "j4-dmenu-desktop --dmenu=\"rofi -dmenu -i\" --no-generic --usage-log=\"/home/tdpeuter/.local/state/dmenu.log\" --term=$term"
M.lock  = "swaylock --daemonize"

M.enable_hy3 = true

return M
