import psutil
from libqtile.log_utils import logger

from settings.widgets.base import ShowHideTextBox


def get_status_sensors() -> float:
    temps = psutil.sensors_temperatures(fahrenheit=False)
    logger.warning("[sensors] %s", str(temps))

    if "coretemp" not in temps:
        return 0

    return temps["coretemp"][0].current


def get_icon_sensors(status: float) -> str:
    logger.warning("[sensors] %s", str(status))
    if status > 70:
        return "psensor_hot"

    return "psensor_normal"


class SensorsTextBox(ShowHideTextBox):
    def calculate_text(self) -> str:
        status = get_status_sensors()
        return f"{status:.1f}°C "
