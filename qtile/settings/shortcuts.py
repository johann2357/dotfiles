from libqtile.config import Group, Key, Match
from libqtile.lazy import lazy
from libqtile.log_utils import logger


def setup_groups() -> list[Group]:
    logger.info("[keys] Setting up groups")
    return [
        Group(
            name="1",
            screen_affinity=0,
            matches=[Match(title=["Brave"])],
        ),
        Group(
            name="2",
            screen_affinity=0,
            matches=[Match(title=["Alacritty"])],
        ),
        Group(
            name="3",
            screen_affinity=0,
            matches=[Match(title=["Google Chrome"])],
        ),
        Group(
            name="4",
            screen_affinity=0,
        ),
        Group(
            name="5",
            screen_affinity=1,
        ),
        Group(
            name="6",
            screen_affinity=1,
            matches=[Match(title=["Slack"])],
        ),
    ]


def setup_keys(
    mod: str,
    terminal: str,
    groups: list[Group],
) -> list[Key]:
    logger.info("[keys] Setting up keys")
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
        Key([mod], "l", lazy.layout.left(), desc="Move focus to left"),
        Key([mod], "h", lazy.layout.right(), desc="Move focus to right"),
        Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
        Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
        # Move windows between left/right columns or move up/down in current stack.
        # Moving out of range in Columns layout will create new column.
        Key(
            [mod, "shift"],
            "h",
            lazy.layout.shuffle_left(),
            desc="Move window to the left",
        ),
        Key(
            [mod, "shift"],
            "l",
            lazy.layout.shuffle_right(),
            desc="Move window to the right",
        ),
        Key(
            [mod, "shift"],
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
        Key(
            [mod, "shift"],
            "r",
            lazy.layout.normalize(),
            desc="Reset all window sizes",
        ),
        Key(
            [mod],
            "w",
            lazy.next_screen(),
            desc="Move to next screen",
        ),
        Key(
            [mod, "shift"],
            "w",
            lazy.prev_screen(),
            desc="Move to prev screen",
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
        Key(
            [mod],
            "space",
            lazy.spawncmd(),
            desc="Spawn a command using a prompt widget",
        ),
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
            [mod],
            # "XF86MonBrightnessUp",
            "F6",
            lazy.spawn("brightnessctl set 5%+"),
            desc="Increase Brightness by 5%",
        ),
        Key(
            [mod],
            # "XF86MonBrightnessDown",
            "F5",
            lazy.spawn("brightnessctl set 5%-"),
            desc="Decrease Brightness by 5%",
        ),
        #   - Screenshot
        Key(
            [mod, "shift"],
            "s",
            lazy.spawn("sshot2clip"),
            desc="Store screenshot in clipboard",
        ),
        Key(
            [mod, "shift"],
            "z",
            lazy.spawn("sshot2file"),
            desc="Store screenshot in ~/Screenshots dir",
        ),
    ]
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

    return keys
