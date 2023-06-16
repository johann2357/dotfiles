import subprocess

from libqtile.log_utils import logger
from libqtile import widget
from libqtile.widget import base

from settings.widgets.base import ShowHideTextBox


def get_volume() -> int:
    get_volume_command = "pamixer --get-volume"
    check_mute_command = "pamixer --get-mute"
    check_mute_string = "true"
    try:
        mixer_out = subprocess.getoutput(get_volume_command)
    except subprocess.CalledProcessError:
        return -1

    check_mute = subprocess.getoutput(check_mute_command)
    logger.warning("[volume] %s %s", str(mixer_out), str(check_mute))

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
