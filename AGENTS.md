# AGENTS.md

This file provides guidance to AI coding agents when working with code in this repository.

## Repository Overview

This is Adam's personal dotfiles repository - a modular configuration management system for Unix-like systems (primarily macOS and Linux). It uses a plugin-based architecture to manage development tools and system configurations.

## Key Architecture

### Plugin System
- Each plugin lives in `plugins/[plugin-name]/` with its own `.sh` file and configuration directories
- `defaults.d/` - Default configuration files that get symlinked automatically  
- `config.d/` - Additional configuration files
- Plugins are loaded via the `FILES_PLUGINS` array in `install_script.sh`

### Core Files
- `sourceme.sh` - Main orchestration script that loads the entire system
- `install_script.sh` - Bootstrap script defining default plugins and configuration
- `.config/` - Application configs that get symlinked to `~/.config`

### Current Active Plugins
Default plugins from `install_script.sh`: asdf, ssh, vim, git-extras, kubernetes, starship, extras, tmux, wezterm

## Development Commands

### Docker Development Environment
- `make build` - Build the Docker container for testing
- `make dev` - Run interactive container with configurations pre-installed
- `make build dev` - Build and run development environment

### Debugging
- Set `FILES_DEBUG=true` environment variable for verbose logging
- `files_plugins_list()` function shows loaded plugins
- `files_debug_on()` and `files_debug_off()` toggle debug mode

## Common Configuration Patterns

### Adding New Plugins
1. Create `plugins/[name]/[name].sh`
2. Add `defaults.d/` directory with config files
3. Add plugin name to `FILES_PLUGINS` array in `install_script.sh`
4. Use `files_linkdir()` function to symlink configurations

### Modifying Existing Configurations
- Most configs are in `plugins/[tool]/defaults.d/`
- Git configuration: `plugins/git-extras/gitconfig`
- Shell helpers: `plugins/extras/defaults.d/899-helpers.sh`
- Neovim: `plugins/nvim/config.d/`
- Starship prompt: `plugins/starship/defaults.d/starship.toml`

### Testing Changes
Use the Docker environment to test configurations safely:
```bash
make build dev
```

## Utility Functions

Key helper functions available in `plugins/extras/defaults.d/899-helpers.sh`:
- `freeport [port]` - Kill processes using specific ports
- `dumptcp [interface]` - TCP dump utility for debugging  
- `fs [path]` - Enhanced file size display
- `targz [file]` - Smart tar.gz creation
- `json` - JSON syntax highlighting
- `check_certificate [domain]` - SSL certificate inspection

## Installation Process

The system automatically installs itself by adding the sourcing line to shell profiles. Configuration files are symlinked from plugin directories to their target locations using the `files_linkdir()` function.
