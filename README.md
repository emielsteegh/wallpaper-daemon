# Wallpaper Daemon

Little tool to get around the imposed (and mildly bleak) wallpaper on your company macbook 😎.

## Usage

Clone this repo wherever you would like, and keep it there.

Run `./install.sh` to install the daemon, and `./uninstall.sh` to uninstall it. Uninstalling does not revert the wallpaper but the management profile will kick it back in a day <sup>[citation needed]</sup>.

After installation a random wallpaper will be selected from the `wallpapers` folder on every login, and when anything other than this tool changes the wallpaper (like the management profile).

To manually change to a random wallpaper run `./set_background.sh -f`.

## Configuration

Add your own wallpapers to the `wallpaper_storage` folder.

Suggested wallpaper sources:
 - [Unsplash](https://unsplash.com/)
 - [Wallpaper Abyss](https://wall.alphacoders.com/)
 - [Wallhaven](https://wallhaven.cc/)
 - [r/wallpapers](https://www.reddit.com/r/wallpapers/)