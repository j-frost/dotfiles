# UI scaling for hidpi displays
export GDK_SCALE=2
export GDK_DPI_SCALE=0.9
export ELM_SCALE=2
export QT_AUTO_SCREEN_SCALE_FACTOR=2
xrandr --dpi 175

# no beeping and faster key repeat
xset -b
xset r rate 220 40

# lock screen after 10 minutes
xautolock -time 10 -locker /home/j-frost/.config/i3/lock.sh &

# xrandr management
~/bin/xrefresh

# manage ssh-keys
keychain ~/.ssh/id_rsa
[ -f ~/.keychain/$HOSTNAME-sh ] && . ~/.keychain/$HOSTNAME-sh 2>/dev/null
[ -f ~/.keychain/$HOSTNAME-sh-gpg ] && . ~/.keychain/$HOSTNAME-sh-gpg 2>/dev/null

# start i3 window manager
exec i3
