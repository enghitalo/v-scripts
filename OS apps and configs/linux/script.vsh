#!/usr/bin/env -S v

import term { bg_yellow, bold, green, red }

// extern_HD_directory := input("Qual o diretório do HD externo?: ")
// println(extern_HD_directory)
if execute('sudo apt update').exit_code == 0 {
	println('apt-get updated')
}else{
	println(bold(red("FAIL<--------------------------->")))
}

if execute('sudo apt install build-essential').exit_code == 0 {
	println('installing build-essential...')
}else{
	println(bold(red("FAIL<--------------------------->")))
}

has_git := execute('git --version').exit_code == 0
if !has_git {
	println(bold('installing git...'))
	execute_or_exit('sudo apt-get -y install git')
	println(bold(green(execute('git --version').output)))
}

has_zsh := execute('zsh --version').exit_code == 0
if !has_zsh {
	println(bold('installing zsh...'))
	execute_or_exit('sudo apt -y install zsh')
	println(bold(green(execute('zsh --version').output)))
}

if !execute('echo \$SHELL').output.contains('/usr/bin/zsh') {
	println(bg_yellow(red('"echo \$SHELL" not have "/usr/bin/zsh"')))
}

has_p10k := execute('[ -f ~/powerlevel10k/powerlevel10k.zsh-theme ]').exit_code == 0
if !has_p10k {
	println(bold('installing p10k...'))
	println(bold('from manual'))
	execute_or_exit('git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k')
	execute_or_exit('echo "source ~/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc')

	println(bold('from Oh My Zsh'))
	execute_or_exit('git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \${ZSH_CUSTOM:-\$HOME/.oh-my-zsh/custom}/themes/powerlevel10k')
	execute_or_exit('echo "source ~/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc')
	println(bold(green(execute('p10k').output)))
}

has_font_directory := execute('[ -f ~/.fonts ]').exit_code == 0
if !has_font_directory {
	execute('mkdir ~/.fonts')
	execute('cp ./"OS apps and configs/linux/font-nerd-font-Ubuntu/Ubuntu Nerd Font Complete Mono.ttf" ~/.fonts')
	execute('cp ./"OS apps and configs/linux/font-nerd-font-Ubuntu/Ubuntu Nerd Font Complete.ttf" ~/.fonts')
	execute('fc-cache -f -v')
}

has_curl := execute('curl --version').exit_code == 0
if !has_curl {
	// from https://www.cyberciti.biz/faq/how-to-install-curl-command-on-a-ubuntu-linux/
	println(bold('installing curl...'))
	execute_or_exit('sudo apt -y install curl')
	execute_or_exit('sudo apt-cache search libcurl | grep python')
	execute_or_exit('sudo apt -y install python3-pycurl')
	execute_or_exit('sudo apt-cache search libcurl')
	println(bold(green(execute('curl --version').output)))
}

if !(execute('wget --version').exit_code == 0) {
	println(bold('installing curl...'))
	execute_or_exit('sudo apt-get -y install wget')
	println(bold(green(execute('wget --version').output)))
}

if !(execute('nvm --version').exit_code == 0) {
	println(bold('installing nvm...'))
	execute_or_exit('wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash')
	/*
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
	*/
	execute_or_exit('export NVM_DIR="\$HOME/.nvm"\n[ -s "\$NVM_DIR/nvm.sh" ] && \\. "\$NVM_DIR/nvm.sh"\n[ -s "\$NVM_DIR/bash_completion" ] && \\. "\$NVM_DIR/bash_completion"')

	if !(execute('node -v').exit_code == 0) {
		println('installing node...')
		execute('nvm install node')
		execute('nvm alias default node')
		println(bold(green(execute('node -v').output)))
	}

	println(bold(green(execute('nvm --version').output)))
}

println('ending script...')
execute_or_exit('sudo apt -y autoremove')
