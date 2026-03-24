#!/usr/bin/env bash
PROFILE_MANAGER=false
PRIVATE=false
# Parse flags
while [[ "$1" == -* ]]; do
  case "$1" in
  --ProfileManager)
    PROFILE_MANAGER=true
    shift
    ;;
  --private-window)
    PRIVATE=true
    shift
    ;;
  *) shift ;;
  esac
done
URL="$1"
# Only allow https and localhost
case "$URL" in
https://*) ;;
http://localhost* | http://\[::1\]*) ;;
*)
  notify-send "Zen Dispatcher" "Blocked non-HTTPS URL: $URL"
  exit 1
  ;;
esac

# Build args
ARGS=()
[[ "$PROFILE_MANAGER" == true ]] && ARGS+=(--ProfileManager)
[[ "$PRIVATE" == true ]] && ARGS+=(--private-window)

# Bypass container routing for certain domains
case "$URL" in
*proton.me*)
  uwsm-app -- zen-twilight "${ARGS[@]}" "$URL"
  exit 0
  ;;
esac

# Define domain → container mappings
case "$URL" in
*claude.ai* | *github.com* | *gitlab.com* | *stackoverflow.com* | *linkedin.com* | http*://127.0.0.1* | localhost*)
  CONTAINER="Productivity"
  ;;
*docker.com* | *hypr.land* | *archlinux.org* | *debian.org*)
  CONTAINER="Tech Documentation"
  ;;
*paypal.com* | *skrill.com*)
  CONTAINER="Personal"
  ;;
*twitch.tv* | *youtube.com* | *youtu.be* | *reddit.com* | *crunchyroll.com* | *discord.com* | *x.com* | *myanimelist.net* | *instagram.com* | *spotify.com* | *discordapp.com*)
  ARGS+=("-P" "Media" "--name" "zen-twilight-media" "--no-remote")
  CONTAINER="Social Media"
  ;;
*store.steampowered.com*)
  ARGS+=("-P" "Media" "--name" "zen-twilight-media" "--no-remote")
  CONTAINER="Gaming"
  ;;
*amazon.de*)
  ARGS+=("-P" "Media" "--name" "zen-twilight-media" "--no-remote")
  CONTAINER="Shopping"
  ;;
*)
  notify-send "External URL ($URL) not yet allowed" -u critical -a "Zen Dispatcher"
  exit 0
  ;;
esac

if command -v uwsm-app &>/dev/null; then
  uwsm-app -- zen-twilight "${ARGS[@]}" "ext+container:name=$CONTAINER&url=$URL"
else
  zen-twilight "${ARGS[@]}" "ext+container:name=$CONTAINER&url=$URL"
fi
