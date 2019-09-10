# Copyright (c) 2019 Zordsdavini
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile.config import EzKey as Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, extension, hook
from subprocess import call
import xrp
import json
from os import path, getenv

from typing import List  # noqa: F401

# monadtall extention to follow maximized window if we have only two
@lazy.function
def z_maximize(qtile):
    l = qtile.current_layout
    g = qtile.current_group
    l.cmd_maximize()
    if len(g.windows) == 2:
        fw = qtile.current_window
        ow = None
        # get other window
        for w in g.windows:
            if w != fw:
                ow = w

        if ow and fw.info()['width'] < ow.info()['width']:
            l.cmd_next()


class Commands:
    autorandr = ['autorandr', '-c']

    def reload_screen(self):
        call(self.autorandr)

commands = Commands()

xresources = path.realpath(getenv('HOME') + '/.Xresources') 
result = xrp.parse_file(xresources, 'utf-8')
font_data = result.resources['*.font'].split(':')
FONT = font_data[0]
FONT_SIZE = int(font_data[1].split('=')[1])

color_data = json.loads(open(getenv('HOME') + '/.cache/wal/colors.json').read())
#BLACK = color_data['colors']['color0']
BLACK = "#15181a"
RED = color_data['colors']['color1']
GREEN = color_data['colors']['color2']
YELLOW = color_data['colors']['color3']
BLUE = color_data['colors']['color4']
MAGENTA = color_data['colors']['color5']
CYAN = color_data['colors']['color6']
WHITE = color_data['colors']['color7']

keys = [
    # Switch between windows in current stack pane
    Key("M-h", lazy.layout.left()),
    Key("M-l", lazy.layout.right()),
    Key("M-k", lazy.layout.down()),
    Key("M-j", lazy.layout.up()),

    # Move windows up or down in current stack
    Key("M-S-h", lazy.layout.shuffle_left()),
    Key("M-S-l", lazy.layout.shuffle_right()),
    Key("M-S-k", lazy.layout.shuffle_down()),
    Key("M-S-j", lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    Key("M-<space>", lazy.layout.next()),

    # Swap panes of split stack
    Key("M-S-<space>", lazy.layout.flip()),

    # Maximize in monadtall
    Key("M-o", z_maximize),
    Key("M-n", lazy.layout.reset()),

    # Switch between monitors
    Key("M-<comma>", lazy.prev_screen()),
    Key("M-<period>", lazy.next_screen()),

    Key("M-<Return>", lazy.spawn("st -e tmux")),
    Key("M-<Tab>", lazy.next_layout()),
    Key("M-S-w", lazy.window.kill()),

    Key("M-C-r", lazy.restart()),
    # Key([mod, "control"], "q", lazy.shutdown()),
    Key("M-C-q", lazy.spawn("slock")),
    Key("M-r", lazy.run_extension(extension.DmenuRun())),
    Key("M-A-l", lazy.run_extension(extension.WindowList())),
    Key("M-C-f", lazy.window.toggle_floating()),
]

groups = [Group(i) for i in "asdfg"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key("M-%s" % i.name, lazy.group[i.name].toscreen()),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key("M-S-%s" % i.name, lazy.window.togroup(i.name)),
    ])

layouts = [
    layout.Max(),
    layout.MonadTall(border_focus=RED, new_at_current=True)
]

widget_defaults = dict(
    font=FONT,
    fontsize=FONT_SIZE,
    padding=3,
    foreground=WHITE,
    background=BLACK
)
extension_defaults = dict(
    dmenu_prompt=">",
    dmenu_font=FONT + '-8',
    background=BLACK,
    foreground=GREEN,
    selected_background=GREEN,
    selected_foreground=BLACK,
    dmenu_height=24,
)

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(),
                widget.CurrentLayoutIcon(scale=0.65),
                widget.WindowName(),
                widget.Clipboard(foreground=RED),
                widget.Moc(play_color=GREEN, noplay_color=YELLOW),
                widget.Systray(),
                widget.Volume(foreground=GREEN),
                widget.KeyboardLayout(configured_keyboards=['us', 'lt', 'ru phonetic'], foreground=GREEN),
                widget.Battery(discharge_char='↓', charge_char='↑', format='{char} {hour:d}:{min:02d}', foreground=YELLOW, low_foreground=RED),
                widget.CheckUpdates(),
                widget.Clock(format='%Y-%m-%d %H:%M'),
            ],
            24,
        ),
        bottom=bar.Bar(
            [
                widget.Backlight(change_command='light -S {0}', foreground=GREEN, backlight_name='intel_backlight'),
                widget.Pomodoro(color_inactive=YELLOW, color_break=GREEN, color_active=RED),
            ],
            24,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(["mod4"], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag(["mod4"], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click(["mod4"], "Button2", lazy.window.toggle_floating())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"


@hook.subscribe.startup_once
def startup():
   commands.reload_screen()


@hook.subscribe.screen_change
def restart_on_randr(qtile, ev):
    commands.reload_screen()
    qtile.cmd_restart()

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"