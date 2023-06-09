import subprocess

import iwlib
import psutil
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Match, Screen
from libqtile.lazy import lazy
from libqtile.log_utils import logger
from libqtile.utils import guess_terminal
from libqtile.widget import base

from settings.themes import Gruvbox
from settings.shortcuts import setup_groups, setup_keys

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


def create_window_name_widget() -> widget.WindowName:
    max_chars = 69

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


class ShowHideTextBox(widget.TextBox):

    def __init__(self, *args, **kwargs):
        kwargs.setdefault(
            "mouse_callbacks",
            {
                "Button1": self.mouse_click,
            },
        )
        self._icon_expand = "▾"
        kwargs.setdefault("text", self._icon_expand)
        super().__init__(*args, **kwargs)

    def calculate_text(self) -> str:
        return "implement this"

    def mouse_click(self):
        self.update(text=self.calculate_text())

    def mouse_enter(self, *args, **kwargs):
        self.update(text=self.calculate_text())

    def mouse_leave(self, *args, **kwargs):
        self.update(text=self._icon_expand)


class WlanTextBox(ShowHideTextBox):

    def calculate_text(self) -> str:
        interface = "wlan0"
        try:
            interface = iwlib.get_iwconfig(interface)
            essid = interface["ESSID"].decode("utf-8")
            disconnected = essid is None
            if disconnected:
                return "disconnected "
            quality = interface["stats"]["quality"]
            percent = quality / 70
            return f"{percent:2.0%} {essid} "
        except Exception:
            logger.exception(
                "%s: Probably your wlan device is switched off or "
                " otherwise not present in your system.",
                self.__class__.__name__,
            )


def get_volume() -> int:
    get_volume_command = "pamixer --get-volume"
    check_mute_command = "pamixer --get-mute"
    check_mute_string = "true"
    try:
        mixer_out = subprocess.getoutput(get_volume_command)
    except subprocess.CalledProcessError:
        return -1

    check_mute = subprocess.getoutput(check_mute_command)

    if check_mute_string in check_mute:
        return -1

    return int(mixer_out)


class VolumeTextBox(ShowHideTextBox):

    def calculate_text(self) -> str:
        volume = get_volume()
        if volume == -1:
            return "Muted"
        return f"{volume}% "


class VolumeIcon(widget.PulseVolume):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.current_icon = "audio-volume-muted"

    def _configure(self, qtile, parent_bar):
        super()._configure(qtile, parent_bar)
        self.setup_images()

    def get_volume(self):
        return get_volume()

    def timer_setup(self) -> None:
        self.update()
        self.timeout_add(self.update_interval, self.timer_setup)

    def _get_icon_key(self, volume: int) -> str:
        if volume <= 0:
            img_name = "audio-volume-muted"
        elif volume <= 30:
            img_name = "audio-volume-low"
        elif volume < 80:
            img_name = "audio-volume-medium"
        else:  # self.volume >= 80:
            img_name = "audio-volume-high"

        return img_name

    def draw(self):
        if self.theme_path:
            self.drawer.clear(self.background or self.bar.background)
            self.drawer.ctx.set_source(self.surfaces[self.current_icon])
            self.drawer.ctx.paint()
            self.drawer.draw(offsetx=self.offset, offsety=self.offsety, width=self.length)
        else:
            base._TextBox.draw(self)

    def update(self):
        """
        same method as in Volume widgets except that here we don't need to
        manually re-schedule update
        """
        vol = self.get_volume()
        if vol != self.volume:
            self.current_icon = self._get_icon_key(volume=vol)
            self.volume = vol
            self.draw()


class BatteryTextBox(ShowHideTextBox):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._battery = widget.battery.load_battery()

    def calculate_text(self) -> str:
        try:
            status = self._battery.update_status()
        except RuntimeError as e:
            return "Error: {}".format(e)
        return f"{status.percent:2.0%} "


class MemoryTextBox(ShowHideTextBox):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.measures = {
            "G": 1024 * 1024 * 1024,
            "M": 1024 * 1024,
            "K": 1024,
            "B": 1,
        }
        self.measure_mem = "G"
        self.calc_mem = self.measures[self.measure_mem]
        self.format = "{MemUsed:.2f} / {MemTotal:.2f} {mm} "

    def calculate_text(self) -> str:
        mem = psutil.virtual_memory()
        val = {}
        val["MemUsed"] = mem.used / self.calc_mem
        val["MemTotal"] = mem.total / self.calc_mem
        val["MemFree"] = mem.free / self.calc_mem
        val["MemPercent"] = mem.percent
        val["mm"] = self.measure_mem
        return self.format.format(**val)


screens = [
    Screen(
        bottom=bar.Bar(
            size=19,
            # background=theme.dark0_hard,  # Gruvbox
            # background="#135868",  # lakerside-5.jpg
            # background="#221a31",  # lake-sunset.jpg
            background="#003558",  # ocean-fishing.jpg
            opacity=0.96,
            margin=[1, 3, 1, 3],  # [N E S W]
            border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color="#221a31",  # lake-sunset.jpg
            border_color="#003558",  # ocean-fishing.jpg
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
            widgets=[
                widget.CurrentLayoutIcon(),
                widget.GroupBox(
                    this_current_screen_border=theme.light0_hard,
                    # highlight_color=["#221a31", "#221a31"],  # lake-sunset.jpg
                    highlight_color=["#003558", "#003558"],  # lake-sunset.jpg
                    borderwidth=1,
                    inactive=theme.gray,
                    disable_drag=True,
                    highlight_method="line",
                ),
                widget.Prompt(
                    prompt=" > ",
                ),
                create_window_name_widget(),
                widget.Spacer(),
                widget.Notify(),
                widget.Systray(),
                widget.BatteryIcon(
                    scale=1,
                    theme_path="/usr/share/icons/Papirus-Dark/24x24/panel/",
                    update_interval=60,
                ),
                BatteryTextBox(),
                widget.Image(
                    filename="/usr/share/icons/Papirus/24x24/panel/indicator-sensors-memory.svg",
                ),
                MemoryTextBox(),
                widget.Image(
                    filename="/usr/share/icons/Papirus/24x24/panel/network-wireless-secure-signal-good.svg",
                ),
                WlanTextBox(),
                VolumeIcon(
                    get_volume_command="pamixer --get-volume",
                    check_mute_command="pamixer --get-mute",
                    check_mute_string="true",
                    theme_path="/usr/share/icons/Papirus/24x24/panel/",
                    volume_app="pamixer",
                    update_interval=30,
                ),
                VolumeTextBox(),
                widget.Clock(
                    format=" %a %d %b %H:%M",
                ),
                # widget.Image(
                #     filename="/usr/share/icons/Papirus/24x24/panel/indicator-cpufreq-25.svg",
                # ),
                # widget.CPU(
                #     format="{load_percent}% ",
                # ),
                # widget.Image(
                #     filename="/usr/share/icons/Papirus/24x24/panel/psensor_normal.svg",
                # ),
                # widget.ThermalSensor(
                #     format="{temp:.1f}{unit}",
                # ),
            ],
        ),
    ),
    Screen(),
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

print("Holis")
logger.warning("Holis")
