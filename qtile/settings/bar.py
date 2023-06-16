import dataclasses
import subprocess
from typing import Any, Callable, Union

import iwlib
import psutil
from libqtile import bar, images, widget
from libqtile.log_utils import logger
from libqtile.widget import base


@dataclasses.dataclass
class IconStatus:
    icon_names: list[str]
    current_icon: str
    get_status_function: Callable
    get_icon_function: Callable
    current_status: Any = None
    theme_path: str = "/usr/share/icons/Papirus-Dark/24x24/panel/"

    def get_icon_for_status(self) -> str:
        """Retrieve specific icon related to the respective status."""
        self.current_status = self.get_status_function()
        self.current_icon = self.get_icon_function(self.current_status)
        return self.current_icon


class IconWidget(base._Widget):
    """Battery life indicator widget."""

    orientations = base.ORIENTATION_HORIZONTAL
    defaults: list[tuple[str, Any, str]] = [
        (
            "update_interval",
            60,
            "Seconds between status updates",
        ),
        (
            "scale",
            1,
            "Scale factor relative to the bar height. Defaults to 1",
        ),
    ]

    def __init__(self, icon_status: IconStatus, **config) -> None:
        super().__init__(length=bar.CALCULATED, **config)
        # base._Widget.__init__(self, length=bar.CALCULATED, **config)
        self.add_defaults(self.defaults)
        self.scale: float = 1.0 / self.scale

        self.length_type = bar.STATIC
        self.length = 0
        self.image_padding = 0
        self.surfaces = {}  # type: dict[str, Img]

        self.icon_status = icon_status

    def _configure(self, qtile, bar) -> None:
        super()._configure(qtile, bar)
        # base._Widget._configure(self, qtile, bar)
        self.image_padding = 0
        self.setup_images()
        self.image_padding = (self.bar.height - self.bar.height / 5) / 2

    def timer_setup(self) -> None:
        self.update()
        self.timeout_add(self.update_interval, self.timer_setup)

    def setup_images(self) -> None:
        d_imgs = images.Loader(self.icon_status.theme_path)(
            *self.icon_status.icon_names
        )

        new_height = self.bar.height * self.scale - self.image_padding
        for key, img in d_imgs.items():
            img.resize(height=new_height)
            if img.width > self.length:
                self.length = int(img.width + self.image_padding * 2)
            self.surfaces[key] = img.pattern

    def draw(self) -> None:
        self.drawer.clear(self.background or self.bar.background)
        self.drawer.ctx.set_source(self.surfaces[self.icon_status.current_icon])
        self.drawer.ctx.paint()
        self.drawer.draw(offsetx=self.offset, offsety=self.offsety, width=self.length)

    def update(self) -> None:
        old_icon = self.icon_status.current_icon
        new_icon = self.icon_status.get_icon_for_status()
        if new_icon != old_icon:
            self.draw()


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


@dataclasses.dataclass
class WlanInfo:
    essid: Union[str, None]
    quality: Union[float, None]

    def get_quality_percentage(self) -> float:
        if self.quality is None:
            return 0
        return self.quality / 70


def get_status_wlan(interface: str = "wlan0") -> WlanInfo:
    interface = iwlib.get_iwconfig(interface)
    return WlanInfo(
        essid=interface["ESSID"].decode("utf-8"),
        quality=interface["stats"]["quality"],
    )


def get_icon_wlan(status: WlanInfo):
    logger.warning("[wlan] %s %s", str(status), str(status.get_quality_percentage()))

    if status.essid is None:
        return "network-wireless-disconnected"

    quality = status.get_quality_percentage()
    if quality < 0.1:
        return "network-wireless-connected-00"
    elif quality < 0.25:
        return "network-wireless-connected-25"
    elif quality < 0.5:
        return "network-wireless-connected-50"
    elif quality < 0.75:
        return "network-wireless-connected-75"
    else:
        return "network-wireless-connected-100"


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
            frequency = interface["Frequency"].decode("utf-8")
            return f"{percent:2.0%} {essid} {frequency}"
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
            self.drawer.draw(
                offsetx=self.offset, offsety=self.offsety, width=self.length
            )
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
            logger.warning("[battery] %s", str(status))
        except RuntimeError as e:
            return "Error: {}".format(e)
        state = "idle"
        if status.state == widget.battery.BatteryState.DISCHARGING:
            state = "discharging"
        elif status.state == widget.battery.BatteryState.CHARGING:
            state = "charging"
        elif status.state == widget.battery.BatteryState.FULL:
            state = "full"
        elif status.state == widget.battery.BatteryState.EMPTY:
            state = "empty"
        return f"{status.percent:2.0%} {state} "


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


def create_bar(theme) -> bar.Bar:
    return bar.Bar(
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
            IconWidget(
                icon_status=IconStatus(
                    icon_names=[
                        "network-wireless-acquiring",
                        "network-wireless-disconnected",
                        "network-wireless-connected-00",
                        "network-wireless-connected-25",
                        "network-wireless-connected-50",
                        "network-wireless-connected-75",
                        "network-wireless-connected-100",
                    ],
                    current_icon="network-wireless-acquiring",
                    get_status_function=get_status_wlan,
                    get_icon_function=get_icon_wlan,
                ),
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
    )
