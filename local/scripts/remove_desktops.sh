if [[ $(bspc query -N -d focused.occupied | wc -l) != 0 || $(bspc query -D -m focused | wc -l) == 1 ]]; then
## Windows still there, or last desktop. Let's skip
exit 1
fi

current_desktop=$(bspc query -D -d focused)
num_desktops=$(bspc query -D | wc -l)

if [[ ${current_desktop} == ${num_desktops} ]]; then
    bspc desktop ${current_desktop} --remove
else
    current_monitor=$(bspc query -M -m focused)
    last_monitor=$(bspc query -M | tail -n 1)
    if [[ ${current_desktop} != ${last_monitor} ]]; then
        # Moving the current desktop onto the last monitor if it' s not already there
        bspc desktop ${current_desktop} --to-monitor ${last_monitor}
    else
        for (( i=$((${current_desktop} + 1)); i<=${num_desktops}; ++i )); do
            bspc desktop ${current_desktop} --swap ${i}
        done
    fi
    bspc desktop ${current_desktop} --remove
fi
