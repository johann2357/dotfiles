from libqtile import bar, widget
from libqtile.log_utils import logger

from settings.widgets.base import (
    IconStatus,
    IconWidget,
)
from settings.widgets.battery import (
    BatteryTextBox,
)
from settings.widgets.cpu import (
    get_icon_cpu,
    get_status_cpu,
    CPUTextBox,
)
from settings.widgets.memory import (
    MemoryTextBox,
)
from settings.widgets.sensors import (
    get_icon_sensors,
    get_status_sensors,
    SensorsTextBox,
)
from settings.widgets.volume import (
    VolumeIcon,
    VolumeTextBox,
)
from settings.widgets.wlan import (
    get_icon_wlan,
    get_status_wlan,
    WlanTextBox,
)


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


def parse_text_notify(text: str) -> str:
    logger.warning(f"[notify] Parsing text: `{text}`")
    return text.split("-")[0]


def create_bar(theme) -> bar.Bar:
    logger.warning("[bar] Creating bar ...")
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
            widget.Notify(parse_text=parse_text_notify),
            widget.Systray(),
            widget.BatteryIcon(
                scale=1,
                theme_path="/usr/share/icons/Papirus-Dark/24x24/panel/",
                update_interval=60,
            ),
            BatteryTextBox(),
            IconWidget(
                icon_status=IconStatus(
                    icon_names=[
                        "indicator-cpufreq",
                        "indicator-cpufreq-25",
                        "indicator-cpufreq-50",
                        "indicator-cpufreq-75",
                        "indicator-cpufreq-100",
                    ],
                    current_icon="indicator-cpufreq",
                    get_status_function=get_status_cpu,
                    get_icon_function=get_icon_cpu,
                    theme_path="/usr/share/icons/Papirus/24x24/panel/",
                ),
            ),
            CPUTextBox(),
            widget.Image(
                filename="/usr/share/icons/Papirus/24x24/panel/indicator-sensors-memory.svg",
            ),
            MemoryTextBox(),
            IconWidget(
                icon_status=IconStatus(
                    icon_names=[
                        "psensor_hot",
                        "psensor_normal",
                    ],
                    current_icon="psensor_normal",
                    get_status_function=get_status_sensors,
                    get_icon_function=get_icon_sensors,
                    theme_path="/usr/share/icons/Papirus/24x24/panel/",
                ),
            ),
            SensorsTextBox(),
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
        ],
    )
