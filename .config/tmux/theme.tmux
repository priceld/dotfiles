#!/usr/bin/env bash
# From https://github.com/olimorris/dotfiles/blob/main/.config/tmux/conf/skin_shared.conf
# Updated to be a bash script based on: https://github.com/dreamsofcode-io/catppuccin-tmux/blob/b4e0715356f820fc72ea8e8baf34f0f60e891718/catppuccin.tmux
PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

get_tmux_option() {
  local option value default
  option="$1"
  default="$2"
  value="$(tmux show-option -gqv "$option")"

  if [ -n "$value" ]; then
    echo "$value"
  else
    echo "$default"
  fi
}

set() {
  local option=$1
  local value=$2
  echo "set $option"
  #tmux_commands+=(set-option -gq "$option" "$value" ";")
  tmux set-option -gq "$option" "$value" ";"
}

setw() {
  local option=$1
  local value=$2
  echo "setw $option"
  #tmux_commands+=(set-window-option -gq "$option" "$value" ";")
  tmux set-window-option -gq "$option" "$value" ";"
}


#################################### PLUGINS ###################################
main() {
  # Aggregate all commands in one array
  local tmux_commands=()


  # NOTE: Pulling in the selected theme by the theme that's being set as local
  # variables.
  source /dev/stdin <<<"$(sed -e "/^[^#].*=/s/^/local /" "${PLUGIN_DIR}/color.tmuxtheme")"

  local mode_separator
  mode_separator=""
  set @mode_indicator_empty_prompt " TMUX #[default] "
  set @mode_indicator_empty_mode_style fg=$color_purple,bold
  set @mode_indicator_prefix_prompt " TMUX #[default]#[fg=$color_blue]$mode_separator"
  set @mode_indicator_prefix_mode_style fg=$color_bg,bg=$color_blue,bold
  set @mode_indicator_copy_prompt " COPY #[default]#[fg=$color_green]$mode_separator"
  set @mode_indicator_copy_mode_style fg=$color_bg,bg=$color_green,bold
  set @mode_indicator_sync_prompt " SYNC #[default]#[fg=$color_red]$mode_separator"
  set @mode_indicator_sync_mode_style fg=$color_bg,bg=$color_red,bold

  # tmux cpu
  set @cpu_percentage_format "%3.0f%%"

  # tmux-online-status
  #set @route_to_ping "vultr.net"   # Use a UK based site to ping
  set @online_icon "#[fg=$color_gray]"
  set @offline_icon "#[fg=$color_red]"

  # tmux-pomodoro
  set @pomodoro_on "  #[fg=$color_red] "
  set @pomodoro_complete "  #[fg=$color_green] "
  set @pomodoro_pause "  #[fg=$color_yellow] "
  set @pomodoro_prompt_break "  #[fg=$color_green] ?"
  set @pomodoro_prompt_pomodoro "  #[fg=$color_red] ?"
  set @pomodoro_interval_display "#[fg=$color_gray]|#[fg=italics]%s"

  # tmux-battery
  set @batt_icon_charge_tier8 ""
  set @batt_icon_charge_tier7 ""
  set @batt_icon_charge_tier6 ""
  set @batt_icon_charge_tier5 ""
  set @batt_icon_charge_tier4 ""
  set @batt_icon_charge_tier3 ""
  set @batt_icon_charge_tier2 ""
  set @batt_icon_charge_tier1 ""

  set @batt_icon_status_charged " "
  set @batt_icon_status_charging "  "
  set @batt_icon_status_discharging " "
  set @batt_icon_status_attached " "
  set @batt_icon_status_unknown " "

  set @batt_remain_short true

  #################################### OPTIONS ###################################

  set status on
  set status-justify centre
  set status-position bottom
  set status-left-length 90
  set status-right-length 90
  set status-style "bg=$color_fg"
  # set window-style ""
  # set window-active-style ""

  set pane-active-border fg=$color_gray
  set pane-border-style fg=$color_gray

  set message-style bg=$color_blue,fg=$color_bg
  setw window-status-separator "   "
  setw mode-style bg=$color_purple,fg=$color_bg

  #################################### FORMAT ####################################

  #set status-left "#{tmux_mode_indicator} #[fg=$color_gray]%R#{pomodoro_status}"
  set status-left "#{tmux_mode_indicator} #[fg=$color_gray]%R"
  #set status-right "#[fg=$color_gray]#{battery_icon_charge}  #{battery_percentage}#{battery_icon_status}#{battery_remain}  CPU:#{cpu_percentage} "
  local soybean_price
  readonly soybean_price=" #(~/work/dotfiles/soybean-bid.sh) "
  set status-right "#[fg=$color_gray]${soybean_price} CPU:#{cpu_percentage} "
  setw window-status-format "#[fg=$color_gray,italics]#I: #[noitalics]#W"
  setw window-status-current-format "#[fg=$color_purple,italics]#I: #[fg=$color_buffer,noitalics,bold]#W"

  #tmux "${tmux_commands[@]}"
}

main "$@"
