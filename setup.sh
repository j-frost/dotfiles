#!/usr/bin/env bash

# Add symlinks for dotfiles in home
current_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
dotfiles_source="${current_dir}/home_files"

while read -r file; do

	relative_file_path="${file#"${dotfiles_source}"/}"
	target_file="${HOME}/${relative_file_path}"
	target_dir="${target_file%/*}"

	if test ! -d "${target_dir}"; then
		mkdir -p "${target_dir}"
	fi

	printf 'Installing dotfiles symlink %s\n' "${target_file}"
	ln -sf "${file}" "${target_file}"

done < <(find "${dotfiles_source}" -type f)

# Install dependencies
sudo apt-get update --yes
sudo apt-get install --yes command-not-found shellcheck httpie &
disown
sudo apt-get update --yes &
disown # for command-not-found
go install mvdan.cc/sh/v3/cmd/shfmt@latest &
disown

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${HOME}"/powerlevel10k &
disown
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions &
disown
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting &
disown
