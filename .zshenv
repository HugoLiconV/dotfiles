# Read by every zsh (interactive or not), so tools and agents that spawn
# non-interactive shells still find mise-managed node, pnpm, etc.
# Interactive shells get the full `mise activate` from .zshrc.
export PATH="$HOME/.local/share/mise/shims:/opt/homebrew/bin:$PATH"
