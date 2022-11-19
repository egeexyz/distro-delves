#!/usr/bin/env ruby

zenity_bin = `which zenity`

if zenity_bin.empty?
  puts "Zenity was not found in PATH. Is it installed?"
  exit 1
end

whoami = ENV["USER"]
`#{zenity_bin.strip} --question --text="Greetings #{whoami.capitalize()}!\n💎💎💎\nHas it been a good Delve so far?"`
