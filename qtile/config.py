from libqtile import layout
from libqtile.config import Click, Drag, Match, Screen
from libqtile.lazy import lazy
from libqtile.log_utils import logger
from libqtile.utils import guess_terminal

from settings.shortcuts import setup_groups, setup_keys
from settings.themes import Gruvbox
from settings.bar import create_bar

theme = Gruvbox
mod = "mod4"
terminal = guess_terminal()

groups = setup_groups()
keys = setup_keys(mod=mod, terminal=terminal, groups=groups)

layouts = [
    layout.Tile(
        border_focus=theme.bright_blue,
        border_norma=theme.dark2,
        max_ratio=0.69,
        ratio=0.5,
        margin=[1, 1, 1, 1],
        border_on_single=False,
        border_width=1,
        expand=True,
    ),
    layout.Max(margin=[1, 1, 1, 1]),
]

widget_defaults = dict(
    font="Meslo LG M Regular Nerd Font Complete.ttf",
    fontsize=13,
    padding=1,
)
extension_defaults = widget_defaults.copy()


screens = [
    Screen(
        bottom=create_bar(theme=theme),
    ),
    Screen(),
]

# Drag floating layouts.
# Button1: Left click
# Button2: Middle click
# Button3: Right click
# Button4: Scroll up
# Button5: Scroll down
# Button6: Scroll left
# Button7: Scroll right
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Click(
        [mod],
        "Button3",
        lazy.window.toggle_floating(),
    ),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
# wmname = "LG3D"
wmname = "Qtile"

print("Holis")
logger.warning("Holis")
