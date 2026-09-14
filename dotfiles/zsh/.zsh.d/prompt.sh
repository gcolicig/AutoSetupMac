show_tool_guide() {
  local C='%F{cyan}' Y='%F{yellow}' G='%F{green}' M='%F{magenta}' W='%F{white}' R='%f'

  print -P "\n${C}┌─ MAC SETUP · TOOLS & ALIASES ───────────────────────────────────────────┐${R}"
  print -P "${C}│${R} ${Y}Navigation${R}  z <name> (zoxide) · fd <name> · Ctrl+R (fzf history)"
  print -P "${C}│${R} ${Y}Files${R}       ll · la · tree (eza) · rg <text>"
  print -P "${C}│${R} ${Y}Git${R}         git · gh · lazygit · delta-powered diffs"
  print -P "${C}│${R} ${Y}Data${R}        jq (JSON) · sed/gsed · awk/gawk · find/gfind"
  print -P "${C}│${R} ${Y}System${R}      htop · stow · todo.sh"
  print -P "${C}│${R} ${Y}Development${R} python · pipx · nvm/Node LTS · hf · zed"
  print -P "${C}│${R} ${Y}Shell${R}       Starship prompt · Antidote plugins · Ghostty · Nerd Font"
  print -P "${C}│${R} ${Y}Apps${R}        Marta · Zed · Ghostty · Discord"
  print -P "${C}├─ COLIMA → INCUS → DOCKER ───────────────────────────────────────────────┤${R}"
  print -P "${C}│${R} ${Y}Colima${R}      colima start · colima status · colima ssh · colima stop"
  print -P "${C}│${R} ${Y}Incus${R}       incus list · incus start/stop <container> · incus shell <container>"
  print -P "${C}│${R} ${Y}Remote${R}      colima ssh -- incus list"
  print -P "${C}│${R} ${Y}Docker${R}      docker ps · docker logs <name> · docker compose up -d/down"
  print -P "${C}│${R} ${Y}Nested${R}      colima ssh -- incus exec <container> -- docker ps"
  print -P "${C}├──────────────────────────────────────────────────────────────────────────┤${R}"
  print -P "${C}│${R} ${G}Aliases${R}     db · todo/t · ta/td/tl/tp/te · cst/csp/cstt (Colima)"
  print -P "${C}│${R} ${M}GNU note${R}    find is GNU find; fd is simpler, but uses different options"
  print -P "${C}│${R} ${W}Help${R}        guide shows this overview again"
  print -P "${C}└──────────────────────────────────────────────────────────────────────────┘${R}\n"
}

alias guide='show_tool_guide'

# Display only a compact hint on interactive shell startup.
if [[ -o interactive && "${MAC_SETUP_SHOW_GUIDE:-1}" == "1" ]]; then
  available_tools=()
  (( $+commands[zoxide] )) && available_tools+=(z)
  for tool in fd rg fzf gh lazygit todo.sh; do
    (( $+commands[$tool] )) && available_tools+=("${tool%.sh}")
  done
  (( $+aliases[ll] )) && available_tools+=(ll)
  print -P "%F{cyan}Tools:%f ${(j: · :)available_tools}  %F{white}│%f  Hilfe: %Bguide%b"
  unset available_tools tool
fi
