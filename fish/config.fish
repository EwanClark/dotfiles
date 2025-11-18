# ------- Environment Variables ------- #
set -gx EDITOR "cursor"
set -gx FZF_DEFAULT_OPTS "
  --style full \
  --border --padding 1,2 \
  --border-label=' FZF ' --input-label=' Input ' \
  --preview='bat --color=always {}' \
  --bind='result:transform-list-label:
    if [[ -z \$FZF_QUERY ]]; then
      echo \" \$FZF_MATCH_COUNT items \"
    else
      echo \" \$FZF_MATCH_COUNT matches for [\$FZF_QUERY] \"
    fi' \
  --color='border:#aaaaaa,label:#cccccc' \
  --color='preview-border:#9999cc,preview-label:#ccccff' \
  --color='list-border:#669966,list-label:#99cc99' \
  --color='input-border:#996666,input-label:#ffcccc' \
  --color='header-border:#6699cc,header-label:#99ccff'
"

# ------- Plugins / Themes ------- #
starship init fish | source
enable_transience
function starship_transient_prompt_func
  starship module character
end
zoxide init --cmd cd fish | source
fzf --fish | source

# ------- Aliases ------- #
alias cls="clear"
alias c="clear && fastfetch"
alias l="eza -lh --icons"
alias la="eza -lah --icons"
alias ls="eza --icons"
alias btop="dgop"

# ------- Startup ------- #
function fish_greeting
  clear && fastfetch
end

