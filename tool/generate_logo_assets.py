#!/usr/bin/env python3
"""Generate ShweWords logo assets for Android, iOS, web, and in-app use.

Run from project root:
  python3 tool/generate_logo_assets.py
  dart run flutter_launcher_icons
"""

from __future__ import annotations

import os
from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parent.parent
SOURCE = ROOT / "logo.png"
FILL = 0.65

# Platform backgrounds (opaque where required by store / PWA spec).
ANDROID_ADAPTIVE_BG = "#00000000"
IOS_BG = "#000000"
WEB_BG = "#000000"


def downscale(img: Image.Image, target: tuple[int, int]) -> Image.Image:
    w, h = img.size
    tw, th = target
    cur = img
    while w // 2 >= tw * 1.5 and h // 2 >= th * 1.5:
        w, h = w // 2, h // 2
        cur = cur.resize((w, h), Image.Resampling.LANCZOS)
    return cur.resize((tw, th), Image.Resampling.LANCZOS)


def load_logo() -> Image.Image:
    img = Image.open(SOURCE).convert("RGBA")
    bbox = img.getbbox()
    return img.crop(bbox) if bbox else img


def place_logo(logo: Image.Image, canvas_size: int, fill_ratio: float) -> Image.Image:
    lw, lh = logo.size
    max_w = canvas_size * fill_ratio
    max_h = canvas_size * fill_ratio
    scale = min(max_w / lw, max_h / lh)
    tw, th = round(lw * scale), round(lh * scale)
    scaled = downscale(logo, (tw, th))
    canvas = Image.new("RGBA", (canvas_size, canvas_size), (0, 0, 0, 0))
    x = (canvas_size - tw) // 2
    y = (canvas_size - th) // 2
    canvas.paste(scaled, (x, y), scaled)
    return canvas


def save_png(img: Image.Image, path: Path) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    img.save(path, "PNG", optimize=True)


def write_logo_assets(logo: Image.Image, out_dir: Path) -> None:
    """Save full-resolution logo for in-app use (Flutter scales per device)."""
    save_png(logo, out_dir / "logo.png")


def main() -> None:
    if not SOURCE.exists():
        raise SystemExit(f"Source logo not found: {SOURCE}")

    logo = load_logo()
    out = ROOT / "assets" / "images"
    icons = ROOT / "AppIcons"

    print(f"Source: {SOURCE} ({logo.size[0]}x{logo.size[1]})")
    print(f"Launcher fill: {FILL * 100:.0f}%")

    write_logo_assets(logo, out)

    icon_512 = place_logo(logo, 512, FILL)
    icon_432 = place_logo(logo, 432, FILL)
    icon_1024 = place_logo(logo, 1024, FILL)

    save_png(icon_512, out / "app_icon.png")
    save_png(icon_432, out / "app_icon_foreground.png")
    save_png(icon_1024, icons / "appstore.png")

    bb = icon_432.getbbox()
    if bb:
        margin = (icon_432.width - (bb[2] - bb[0])) / 2
        print(
            f"Foreground: {bb[2]-bb[0]}x{bb[3]-bb[1]}px, "
            f"margin {margin:.0f}px ({margin / icon_432.width * 100:.0f}%)"
        )

    print("Done. Run: dart run flutter_launcher_icons")


if __name__ == "__main__":
    main()
