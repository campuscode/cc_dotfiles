#!/bin/bash
#=======================================================================================================================
# Export and import Gnome Terminal profiles
#=======================================================================================================================

. "$(dirname "$(realpath "$0")")/common.sh"

USAGE_INFO="Usage: $0 import|export <filename>"

# Check variables
mode="$1"
filename="$2"
[[ -z "$mode"     ]] && usage "No mode specified"
[[ -z "$filename" ]] && usage "No filename specified"

# Get default profile ID
profile="$(gsettings get org.gnome.Terminal.ProfilesList default)"
profile="${profile:1:-1}" # remove leading and trailing single quotes

case "$mode" in
    # Export profile
    export)
        dconf dump "/org/gnome/terminal/legacy/profiles:/:$profile/" > "$filename"
        log "Saved the default profile ${CLR_VAR}${profile}${CLR_OFF} in ${CLR_VAR}${filename}${CLR_OFF}"
        ;;

    # Import profile
    import)
        [[ ! -r "$filename" ]] && err "Failed to read from file $filename"
        dconf load "/org/gnome/terminal/legacy/profiles:/:$profile/" < "$filename"
        log "Loaded ${CLR_VAR}${filename}${CLR_OFF} into the default profile ${CLR_VAR}${profile}${CLR_OFF}"
        ;;

    *)
        usage "Incorrect mode: $mode"
        ;;
esac
