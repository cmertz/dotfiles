fzf_aws_prof() {
	local output
	output=$(grep -e '^.profile' $HOME/.aws/config | awk -F"[][]" '{print $2}' |while read a p ; do echo "AWS_PROFILE=$p" ; done | fzf +s --tac) || return

	BUFFER="export $output"
	zle end-of-line
}

zle -N awsprof fzf_aws_prof
bindkey '^b' awsprof
