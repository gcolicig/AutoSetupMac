# Load environment and PATH before detecting tools or defining integrations.
for config_file in \
  ~/.zsh.d/env.sh \
  ~/.zsh.d/plugins.sh \
  ~/.zsh.d/commands.sh \
  ~/.zsh.d/aliases.sh \
  ~/.zsh.d/completions.sh \
  ~/.zsh.d/prompt.sh; do
  [[ -r "$config_file" ]] && source "$config_file"
done
