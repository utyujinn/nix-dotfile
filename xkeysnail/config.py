import re
from xkeysnail.transform import *

# define timeout for multipurpose_modmap
define_timeout(1)

# [Global modemap] Change modifier keys as in xmodmap
define_modmap({
    Key.CAPSLOCK: Key.LEFT_CTRL,
    Key.MUHENKAN: Key.RIGHT_ALT,
})

define_multipurpose_modmap({
    Key.ENTER: [Key.ENTER, Key.RIGHT_CTRL],
    Key.HENKAN: [Key.ESC, Key.RIGHT_META],
})

define_keymap(None, {

  # for blender
    K("KATAKANAHIRAGANA"): K("BTN_MIDDLE"),
    K("LShift-KATAKANAHIRAGANA"): K("LShift-BTN_MIDDLE"),

    K("RAlt-Key_1"): K("KP1"),
    K("RAlt-Key_2"): K("KP2"),
    K("RAlt-Key_3"): K("KP3"),
    K("RAlt-Key_4"): K("KP4"),
    K("RAlt-Key_5"): K("KP5"),
    K("RAlt-Key_6"): K("KP6"),
    K("RAlt-Key_7"): K("KP7"),
    K("RAlt-Key_8"): K("KP8"),
    K("RAlt-Key_9"): K("KP9"),
    K("RAlt-Key_0"): K("KP0"),

    K("RAlt-MINUS"): K("KPMINUS"),
    K("RAlt-EQUAL"): K("KPPLUS"), 
    K("RAlt-DOT"): K("KPDOT"),
    K("RAlt-SLASH"): K("KPSLASH"),
    K("RAlt-LEFT_BRACE"): K("KPASTERISK"), 

    K("RAlt-h"): K("LEFT"),
    K("RAlt-j"): K("DOWN"),
    K("RAlt-k"): K("UP"),
    K("RAlt-l"): K("RIGHT"),

    K("RAlt-p"): K("HOME"),
    K("RAlt-n"): K("END"),

    K("RSuper-h"): K("Alt-LEFT"),
    K("RSuper-j"): K("Alt-DOWN"),
    K("RSuper-k"): K("Alt-UP"),
    K("RSuper-l"): K("Alt-RIGHT"),

    K("RSuper-n"): K("PAGE_DOWN"),
    K("RSuper-p"): K("PAGE_UP"),
}, "Global")
