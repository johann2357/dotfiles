from enum import Enum

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal


class Gruvbox(str, Enum):
    dark0_hard = "#1d2021"  # 29-32-33
    dark0 = "#282828"  # 40-40-40
    dark0_soft = "#32302f"  # 50-48-47
    dark1 = "#3c3836"  # 60-56-54
    dark2 = "#504945"  # 80-73-69
    dark3 = "#665c54"  # 102-92-84
    dark4 = "#7c6f64"  # 124-111-100
    dark4_256 = "#7c6f64"  # 124-111-100
    gray_245 = "#928374"  # 146-131-116
    gray_244 = "#928374"  # 146-131-116
    gray = "#928374"  # 146-131-116
    light0_hard = "#f9f5d7"  # 249-245-215
    light0 = "#fbf1c7"  # 253-244-193
    light0_soft = "#f2e5bc"  # 242-229-188
    light1 = "#ebdbb2"  # 235-219-178
    light2 = "#d5c4a1"  # 213-196-161
    light3 = "#bdae93"  # 189-174-147
    light4 = "#a89984"  # 168-153-132
    light4_256 = "#a89984"  # 168-153-132
    bright_red = "#fb4934"  # 251-73-52
    bright_green = "#b8bb26"  # 184-187-38
    bright_yellow = "#fabd2f"  # 250-189-47
    bright_blue = "#83a598"  # 131-165-152
    bright_purple = "#d3869b"  # 211-134-155
    bright_aqua = "#8ec07c"  # 142-192-124
    bright_orange = "#fe8019"  # 254-128-25
    neutral_red = "#cc241d"  # 204-36-29
    neutral_green = "#98971a"  # 152-151-26
    neutral_yellow = "#d79921"  # 215-153-33
    neutral_blue = "#458588"  # 69-133-136
    neutral_purple = "#b16286"  # 177-98-134
    neutral_aqua = "#689d6a"  # 104-157-106
    neutral_orange = "#d65d0e"  # 214-93-14
    faded_red = "#9d0006"  # 157-0-6
    faded_green = "#79740e"  # 121-116-14
    faded_yellow = "#b57614"  # 181-118-20
    faded_blue = "#076678"  # 7-102-120
    faded_purple = "#8f3f71"  # 143-63-113
    faded_aqua = "#427b58"  # 66-123-88
    faded_orange = "#af3a03"  # 175-58-3


theme = Gruvbox
mod = "mod4"
terminal = guess_terminal()

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "n", lazy.layout.next(), desc="Move window focus to other window"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key(
        [mod],
        "comma",
        lazy.layout.decrease_ratio(),
        desc="Shrink master",
    ),
    Key(
        [mod],
        "period",
        lazy.layout.increase_ratio(),
        desc="Grow master",
    ),
    KeyChord(
        [mod],
        "w",
        [
            Key([], "l", lazy.layout.left(), desc="Move focus to left"),
            Key([], "h", lazy.layout.right(), desc="Move focus to right"),
            Key([], "j", lazy.layout.down(), desc="Move focus down"),
            Key([], "k", lazy.layout.up(), desc="Move focus up"),
            # Move windows between left/right columns or move up/down in current stack.
            # Moving out of range in Columns layout will create new column.
            Key(
                ["shift"],
                "h",
                lazy.layout.shuffle_left(),
                desc="Move window to the left",
            ),
            Key(
                ["shift"],
                "l",
                lazy.layout.shuffle_right(),
                desc="Move window to the right",
            ),
            Key(
                ["shift"],
                "j",
                lazy.layout.shuffle_down(),
                desc="Move window down",
            ),
            Key(
                [mod, "shift"],
                "k",
                lazy.layout.shuffle_up(),
                desc="Move window up",
            ),
            Key([], "r", lazy.layout.normalize(), desc="Reset all window sizes"),
        ],
    ),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    # TODO: figure out what this is for
    # Key(
    #     [mod, "shift"],
    #     "Return",
    #     lazy.layout.toggle_split(),
    #     desc="Toggle between split and unsplit sides of stack",
    # ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "space", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    # MEDIA KEYS
    #   - Volume
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("pamixer --decrease 5"),
        desc="Lower Volume by 5%",
    ),
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("pamixer --increase 5"),
        desc="Increase Volume by 5%",
    ),
    Key(
        [],
        "XF86AudioMute",
        lazy.spawn("pamixer --toggle-mute"),
        desc="Toggle Mute",
    ),
    #   - Brightness
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn("brightnessctl set +5%"),
        desc="Increase Brightness by 5%",
    ),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn("brightnessctl set 5%-"),
        desc="Decrease Brightness by 5%",
    ),
]

groups = [Group(i) for i in "123456"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.Tile(
        border_focus=theme.bright_blue,
        border_norma=theme.dark2,
        max_ratio=0.69,
        ratio=0.5,
        margin=[3, 3, 3, 3],
        border_on_single=False,
        border_width=3,
    ),
    layout.Max(margin=[3, 3, 3, 3]),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="Meslo LG M Regular Nerd Font Complete.ttf",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()


def create_window_name_widget() -> widget.WindowName:
    max_chars = 39

    def window_name_parse(name: str) -> str:
        if name == "goto":
            name = "Focus Mode - Alacritty"
        parts = name.split("-")
        if len(parts) < 2:
            return name.ljust(max_chars)
        details = "-".join(parts[0:-1])
        return f"{parts[-1]} - {details}".ljust(max_chars)

    empty_group_string = max_chars * " "

    return widget.WindowName(
        max_chars=max_chars,
        empty_group_string=empty_group_string,
        parse_text=window_name_parse,
    )


screens = [
    Screen(
        top=bar.Bar(
            widgets=[
                widget.CurrentLayout(),
                widget.GroupBox(this_current_screen_border=theme.gray),
                widget.Prompt(),
                create_window_name_widget(),
                widget.Clock(format="%a %d %b  %H:%M"),
                widget.Spacer(),
                widget.Systray(),
                widget.Battery(
                    format=" Battery {char}{percent:2.0%}",
                    unknown_char="~",
                    charge_char="^",
                    discharge_char="v",
                ),
                widget.PulseVolume(
                    fmt=" Vol {}",
                    get_volume_command="pamixer --get-volume",
                    volume_app="pamixer",
                ),
                widget.KeyboardLayout(
                    fmt=" ({})",
                ),
                widget.Net(
                    prefix="M",
                    format=" {down} ↓↑{up}",
                ),
                widget.CPU(
                    format=" CPU {load_percent}%",
                ),
                widget.ThermalSensor(
                    format=" {temp:.1f}{unit}",
                ),
                widget.Memory(
                    format=" Mem {MemUsed:.2f}/{MemTotal:.2f}{mm}",
                    measure_mem="G",
                ),
                widget.CheckUpdates(
                    update_interval=60 * 60 * 3,
                ),
            ],
            size=17,
            opacity=0.59,
            background=theme.dark0_hard,
            margin=[3, 3, 3, 3],
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
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
