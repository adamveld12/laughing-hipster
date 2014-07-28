exec = require('child_process').exec
path = require('path')
platform = require('os').platform

###
   Opens a terminal in the given directory, as specefied by the config
###
open_terminal = (dirpath) ->
  # Figure out the app and the arguments
  app = atom.config.get('atom-terminal.app')
  args = atom.config.get('atom-terminal.args')

  # get options
  setWorkingDirectory = atom.config.get('atom-terminal.setWorkingDirectory')
  surpressDirArg = atom.config.get('atom-terminal.surpressDirectoryArgument')
  runDirectly = atom.config.get('atom-terminal.MacWinRunDirectly')

  # Start assembling the command line
  cmdline = "\"#{app}\" #{args}"

  # If we do not supress the directory argument, add the directory as an argument
  if !surpressDirArg
      cmdline  += "\"#{dirpath}\""

  # For mac, we prepend open -a unless we run it directly
  if platform() == "darwin" && !runDirectly
    cmdline = "open -a " + cmdline

  # for windows, we prepend start unless we run it directly.
  if platform() == "win32" && !runDirectly
    cmdline = "start \"\" " + cmdline

  # Set the working directory if configured
  if setWorkingDirectory
    exec cmdline, cwd: dirpath if dirpath?
  else
    exec cmdline if dirpath?


module.exports =
    activate: ->
        atom.workspaceView.command "atom-terminal:open", => @open()
        atom.workspaceView.command "atom-terminal:open-project-root", => @openroot()
    open: ->
        filepath = atom.workspaceView.find('.tree-view .selected')?.view()?.getPath?()
        if filepath
            open_terminal path.dirname(filepath)
    openroot: ->
        if atom.project.path
            open_terminal atom.project.path

# Set per-platform defaults
if platform() == 'darwin'
  # Defaults for Mac, use Terminal.app
  module.exports.configDefaults = {
        app: 'Terminal.app'
        args: ''
        surpressDirectoryArgument: false
        setWorkingDirectory: false
        MacWinRunDirectly: false
  }
else if platform() == 'win32'
  # Defaults for windows, use cmd.exe as default
  module.exports.configDefaults = {
        app: 'C:\\Windows\\System32\\cmd.exe'
        args: ''
        surpressDirectoryArgument: false
        setWorkingDirectory: true
        MacWinRunDirectly: false
  }
else
    # Defaults for all other systems (linux I assume), use xterm
    module.exports.configDefaults = {
        app: '/usr/bin/xterm'
        args: ''
        surpressDirectoryArgument: true
        setWorkingDirectory: true
        MacWinRunDirectly: false
    }
