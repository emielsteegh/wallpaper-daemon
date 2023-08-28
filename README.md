# Wallpaper Daemon

Little tool to get around the imposed (and mildly bleak) wallpaper on your managed macbook 😎.

## Usage

**1. Clone**<br>
Clone this repo wherever you would like, and keep it there. 

**2. Install/Unisntall**<br>
Run `./install.sh` to install the daemon, and `./uninstall.sh` to uninstall it. Uninstalling does not revert the wallpaper, but the management profile will kick it back in a day <sup>[citation needed]</sup>.

**3. ???**<br>
After installation a random wallpaper will be selected from the `wallpaper-storage` folder on every login, and when anything other than this tool changes the wallpaper (like the management profile).

To manually change to a random wallpaper run `./set_background.sh -f`.

**4. Profit**<br>
Enjoy your own wallpaper(s).

## Configuration

Add your wallpapers to the `wallpaper_storage` folder for them to randomly get picked up. Placing a single image means you won't have a random rotation. The accepted filetype is `.jpg`/`.jpeg`. 

Suggested wallpaper sources:
 - [Unsplash](https://unsplash.com/s/photos/minimal-wallpaper)
 - [Shopify Burst](https://burst.shopify.com)
 - [r/wallpapers](https://www.reddit.com/r/wallpapers/)
