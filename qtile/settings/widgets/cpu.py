import dataclasses

import psutil
from libqtile.log_utils import logger

from settings.widgets.base import ShowHideTextBox


@dataclasses.dataclass
class CPUInfo:
    load_percent: float
    current_freq: float
    max_freq: float
    min_freq: float


def get_status_cpu() -> CPUInfo:
    # cpu_usage = psutil.cpu_percent(interval=1)
    load_percent = round(psutil.cpu_percent(), 1)
    freq = psutil.cpu_freq()
    freq_current = round(freq.current / 1000, 1)
    freq_max = round(freq.max / 1000, 1)
    freq_min = round(freq.min / 1000, 1)

    return CPUInfo(
        load_percent=load_percent,
        current_freq=freq_current,
        max_freq=freq_max,
        min_freq=freq_min,
    )


def get_icon_cpu(status: CPUInfo):
    logger.warning("[cpu] %s", str(status))

    if status.load_percent < 25:
        return "indicator-cpufreq-25"
    elif status.load_percent < 50:
        return "indicator-cpufreq-50"
    elif status.load_percent < 75:
        return "indicator-cpufreq-75"
    else:
        return "indicator-cpufreq-100"


class CPUTextBox(ShowHideTextBox):
    def calculate_text(self) -> str:
        status = get_status_cpu()
        return f"{status.current_freq}/{status.max_freq} GHz {status.load_percent}% "
