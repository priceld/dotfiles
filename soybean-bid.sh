#!/bin/bash
echo "$(tail -n 1 "$HOME/.config/commodity-checker/bids.txt")" | awk -F ',' '{print $(NF-1)}'

# To get this to show up in my tmux status bar, I had to manually edit the tmux theme plugin
# I'm using (catpuccin) with the following:
# local soybean_price_column
# readonly soybean_price_column="#[fg=$thm_yellow,bg=$thm_bg,nobold,nounderscore,noitalics]$right_separator#[fg=$thm_bg,bg=$thm_yellow,nobold,nounderscore,noitalics] #[fg=$thm_fg,bg=$thm_gray] #(~/work/dotfiles/soybean-bid.sh) "
# set status-right "${soybean_price_column}${right_column1},${right_column2}"