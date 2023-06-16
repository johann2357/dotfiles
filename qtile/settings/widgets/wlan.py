import dataclasses
from typing import Union

import iwlib
from libqtile.log_utils import logger

from settings.widgets.base import ShowHideTextBox


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
    if quality < 0.10:
        return "network-wireless-connected-00"
    elif quality < 0.30:
        return "network-wireless-connected-25"
    elif quality < 0.60:
        return "network-wireless-connected-50"
    elif quality < 0.90:
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
