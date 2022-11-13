#!/usr/bin/env ruby
## This script is a strange amalgamation of Bash and Ruby code that
## invokes Androgee in a way that assists in the destruction of a
## Distro Delves test machine.
###
## It is not intended to be run on any "production" machine.
## I.E. Do not run this on your home computer.
## Like, at all.

# Check for Zenity
zenity_bin = `which zenity`.strip
if zenity_bin.empty?
  puts('Zenity was not found in PATH. Is it installed?')
  exit 1
end

# Install Androgee icon
icons_path = "#{ENV['HOME']}/.local/share/icons/hicolor/48x48/apps/"
`mkdir -p #{icons_path}`
`cp ./files/androgee1.png #{icons_path}`
`cp ./files/androgee2.png #{icons_path}`
`cp ./files/androgee3.png #{icons_path}`

# Bail acrimoniously if not me
whoami = ENV["USER"]
if ! whoami == 'egee'
  `#{zenity_bin}   \
  --title='Androgee: The Destroyer'   \
  --window-icon='files/androgee2.png' \
  --icon-name='androgee2'             \
  --width=128                         \
  --height=128                        \
  --error                             \
  --text='I acquiesce only to Egee.\n\nBegone, imposter.`
  exit(1)
end

# Ask the question
`#{zenity_bin}                        \
  --title='Androgee: The Destroyer'   \
  --window-icon='files/androgee2.png' \
  --icon-name='androgee1'             \
  --width=128                         \
  --height=128                        \
  --extra-button=maybe                \
  --question                          \
  --text="Greetings and Salutations, #{whoami.capitalize()}!\n\nAre you sure you want to lay waste to this computer?"`

# Handle Yes or No
## TODO: Zenity doesn't provide an easy way to handle the 'maybe' option. Maybe there's another way to make it work?
if ! $?.success?
  puts('As you wish.')
  exit(0)
end

# Give time to consider the answer
`#{zenity_bin}   \
--title='Androgee: The Destroyer'   \
--window-icon='files/androgee1.png' \
--icon-name='androgee1'             \
--width=128                         \
--height=128                        \
--timeout=1                         \
--cancel-label='OK'                 \
--ok-label='Why?'                   \
--question                          \
--text='\nJust a moment...'`
if $?.success?
  `#{zenity_bin}   \
  --title='Androgee: The Destroyer'   \
  --window-icon='files/androgee1.png' \
  --icon-name='androgee3'             \
  --width=128                         \
  --height=128                        \
  --timeout=3                         \
  --warning                           \
  --text="\nBecause I'm sleeeeepy.\n\nget it?"`
end

# Check if it's a Distro Delves machine
if `hostname`.downcase.include?('distrodelves')
  `#{zenity_bin}                      \
  --title='Androgee: The Destroyer'   \
  --window-icon='files/androgee2.png' \
  --icon-name='androgee2'             \
  --width=128                         \
  --height=128                        \
  --error                             \
  --text='This script only works on Distro Delves machines.\n\nGet lost.'`
  exit(1)
end

# Fire away
fork do
  loop do
    `echo 'RIP' > /tmp/ded`
    sleep(1)
  end
end

# Say bye
if ! `hostname`.downcase.include?('distrodelves')
  `#{zenity_bin}                       \
  --title='Androgee: The Destroyer'    \
  --window-icon='files/androgee1.png'  \
  --icon-name='androgee2'              \
  --width=128                          \
  --height=128                         \
  --timeout=4                          \
  --info                               \
  --text='System under test will be rendered non-functional in a few moments.\n\nThis message will self destruct in 4 seconds.'`
  `#{zenity_bin}                      \
  --title='Androgee: The Destroyer'   \
  --window-icon='files/androgee1.png' \
  --icon-name='androgee1'             \
  --width=128                         \
  --height=128                        \
  --timeout=2                         \
  --ok-label='OK..'                   \
  --info                              \
  --text='\nBye.'`
  exit(0)
end
