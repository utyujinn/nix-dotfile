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

    K("GRAVE"): K("ESC"),
  # 無変換 + 数字キー -> テンキーの数字
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

    # 無変換 + 記号 -> テンキーの記号
    K("RAlt-MINUS"): K("KPMINUS"),
    K("RAlt-EQUAL"): K("KPPLUS"), # Shiftを押さずに+を入力するため
    K("RAlt-DOT"): K("KPDOT"),
    K("RAlt-SLASH"): K("KPSLASH"),
    K("RAlt-LEFT_BRACE"): K("KPASTERISK"), # 日本語キーボードの「@」の位置

    # 変換 + H,J,K,L -> Vimライクなカーソル移動
    # アプリケーションを問わず、矢印キーとして動作する
    K("RAlt-h"): K("LEFT"),
    K("RAlt-j"): K("DOWN"),
    K("RAlt-k"): K("UP"),
    K("RAlt-l"): K("RIGHT"),

    # 変換 + U/I -> Home/End
    K("RAlt-u"): K("HOME"),
    K("RAlt-i"): K("END"),

    K("RSuper-h"): K("Alt-LEFT"),
    K("RSuper-j"): K("Alt-DOWN"),
    K("RSuper-k"): K("Alt-UP"),
    K("RSuper-l"): K("Alt-RIGHT"),

    K("RSuper-n"): K("PAGE_DOWN"),
    K("RSuper-p"): K("PAGE_UP"),
}, "Global")
