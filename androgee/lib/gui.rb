require_relative 'helpers.rb'

# Find Zenity
@zenity_bin = `which zenity`.strip
if @zenity_bin.empty?
  puts('Zenity was not found in PATH. Is it installed?')
  exit 1
end

@base_zenity_args = "--title='Androgee!' --icon-name=androgee1 --window-icon='assets/androgee1.png' --width=128 --height=128"

# Zenity helpers
def info(text)
  zenity_arg_overrides = @base_zenity_args  + " --info --text='#{text}'"
  system("#{@zenity_bin} #{zenity_arg_overrides}")
end

def question(text, title=nil)
  zenity_arg_overrides = @base_zenity_args    + " --question --text='#{text}'"
  zenity_arg_overrides = zenity_arg_overrides + " --title='#{title}'" if title
  die('Fine bye.') if ! system("#{@zenity_bin} #{zenity_arg_overrides}")
end

def folder_chooser(text, title=nil)
  zenity_arg_overrides = @base_zenity_args    + " --file-selection --directory --text='#{text}'"
  zenity_arg_overrides = zenity_arg_overrides + " --title='#{title}'" if title
  choice = `#{@zenity_bin} #{zenity_arg_overrides}`.strip()
  die('Fine bye.') if choice.empty?
  return choice
end

def show_game_list(game_index, title='Androgee!')
  zenity_arg_overrides = @base_zenity_args    + " --list --width=512 --height=256 --title='#{title}' --column='Game To Install' --column='Platform' --column='Genre'"
  zenity_arg_overrides = zenity_arg_overrides + " --title='#{title}'" if title
  game_index["supported_games"].each do |name, metadata|
    zenity_arg_overrides = zenity_arg_overrides + " '#{name}' '#{metadata['platform']}' '#{metadata['genre']}'"
  end

  choice = `#{@zenity_bin} #{zenity_arg_overrides}`.strip()
  die('Fine bye.') if choice.empty?
  return choice
end