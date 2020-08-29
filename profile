XDG_CONFIG_HOME="$HOME/.config"
[ "$XDG_CURRENT_DESKTOP" = "KDE" ] || [ "$XDG_CURRENT_DESKTOP" = "GNOME" ] || export QT_QPA_PLATFORMTHEME="qt5ct"

export XDG_CONFIG_HOME;
export QT_QPA_PLATFORMTHEME="qt5ct";

## Fix for UI issue in keepassxc
export QT_AUTO_SCREEN_SCALE_FACTOR=0;
