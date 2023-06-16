import psutil
from libqtile import widget
from libqtile.log_utils import logger

from settings.widgets.base import (
    ShowHideTextBox,
)


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
        self.format = "{MemUsed:.2f}/{MemTotal:.2f} {mm}B "

    def calculate_text(self) -> str:
        mem = psutil.virtual_memory()
        val = {}
        val["MemUsed"] = mem.used / self.calc_mem
        val["MemTotal"] = mem.total / self.calc_mem
        val["MemFree"] = mem.free / self.calc_mem
        val["MemPercent"] = mem.percent
        val["mm"] = self.measure_mem
        return self.format.format(**val)
