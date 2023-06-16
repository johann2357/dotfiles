import dataclasses
from typing import Any, Callable

from libqtile import bar, images, widget
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
