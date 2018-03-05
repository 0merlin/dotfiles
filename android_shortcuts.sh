alias lc="adb logcat"
alias android_installed='adb shell "pm list packages -f" | cut -f 2 -d "=" | sort'
alias adb_refresh='adb shell am broadcast -a android.intent.action.MEDIA_MOUNTED -d file:///sdcard'

alias adb_home='adb shell input keyevent 3'
alias adb_back='adb shell input keyevent 4'
alias adb_volume_up='adb shell input keyevent 24'
alias adb_volume_down='adb shell input keyevent 25'
alias adb_camera='adb shell input keyevent 27'
alias adb_power='adb shell input keyevent 26'
alias adb_recents='adb shell input keyevent KEYCODE_APP_SWITCH'
alias adb_notification_open='adb shell service call statusbar 1'
alias adb_notification_close='adb shell service call statusbar 2'
alias adb_tab="adb shell input keyevent 61"
alias adb_enter="adb shell input keyevent 66"
alias adb_rotate_disable='adb shell settings put system accelerometer_rotation 0'
alias adb_rotate_enable='adb shell settings put system accelerometer_rotation 1'
alias adb_rotate_portrait='adb shell settings put system user_rotation 0'
alias adb_rotate_landscape='adb shell settings put system user_rotation 1'
alias adb_rotate_reverse_portrait='adb shell settings put system user_rotation 2'
alias adb_rotate_reverse_landscape='adb shell settings put system user_rotation 3'

alias adb_kill="adb shell am force-stop"
alias adb_clear="adb shell pm clear"

adb_tap()
{
  adb shell input tap $1 $2
}

current_activity()
{
  adb shell dumpsys activity activities | grep "mFocusedActivity" | cut -d' ' -f6 | cut -d '/' -f2
}

wait_for_activity()
{
  while [[ "$(current_activity)" != "$1" ]]; do sleep 0.3; done
}



shot()
{
  adb shell screencap -p /sdcard/screen.png
  adb pull /sdcard/screen.png
  adb shell rm /sdcard/screen.png
  if [ $# -eq 1 ]; then
    mv screen.png $1.png
  else
    open screen.png
  fi
}

pull()
{
  for a in "$@"; do
    adb pull "$a"
  done
}

push()
{
  for a in "$@"; do
    adb push "$a" /sdcard/
  done
}

kbd()
{
  adb shell input text "'$@'"
}

adb_launch()
{
  for a in "$@"; do
    adb shell monkey -p $a -c android.intent.category.LAUNCHER 1
  done
}
export ANDROID_HOME=~/Library/Android/sdk
