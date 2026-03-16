# add topic folders that contain completion functions to fpath
for topic_folder ($ZSH/functions $ZSH/zsh) if [ -d $topic_folder ]; then fpath=($topic_folder $fpath); fi;
