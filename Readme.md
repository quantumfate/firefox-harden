# Firefox Desktop Hardening

Routing [xdg-open](https://linux.die.net/man/1/xdg-open) to specified [Firefox Containers](https://support.mozilla.org/en-US/kb/how-use-firefox-containers) and/or [Firefox Profiles](https://support.mozilla.org/en-US/kb/profile-manager-create-remove-switch-firefox-profiles?redirectslug=profile-manager-create-and-remove-firefox-profiles&redirectlocale=en-US) to enforce [PERSEC/OPSEC](https://www.militaryspot.com/resources/opsec-and-persec).
Works with any Firefox based browser -- I'm using [Zen-Twilight](https://zen-browser.app/).

Requirements:

- [Open external links in a container](https://addons.mozilla.org/en-US/firefox/addon/open-url-in-container/) Firefox Extension
- [Firefox Multi-Account Containers (Recommended)](https://addons.mozilla.org/en-US/firefox/search/?q=Firefox%20Multi-Account%20Containers) Firefox Extension
- [UWSM (Optional)](https://github.com/Vladimir-csp/uwsm)

## Setup

1. Install the Desktop file [zen-dispatcher.desktop](./zen-dispatcher.desktop)
2. Install [zen-dispatcher.sh](./zen-dispatcher.sh) executable and update the path in [zen-dispatcher.desktop](./zen-dispatcher.desktop)
3. Make sure [zen-dispatcher.desktop](./zen-dispatcher.desktop) is your default with [mimeapps.list](./mimeapps.list)

## Configuration

Configure the URLs of the `switch-case` statement in [zen-dispatcher.sh](./zen-dispatcher.sh) to route into a specific container by setting `CONTAINER="Gaming"` for example. You can also specify any non-default profile by appending additional ARGS such as `ARGS+=("-P" "Media" "--name" "zen-twilight-media" "--no-remote")`.
