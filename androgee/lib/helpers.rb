require 'fileutils'
require 'benchmark'

# Basically abort() but without the stacktrace.
def die(msg)
  puts(msg)
  exit()
end

# Unsophisticated way of determining the package manager.
def get_pkg_mgr()
  ['apt-get', 'dnf', 'zypper'].each do |pkg_mgr|
    if system("which #{pkg_mgr}") then
      return pkg_mgr
    end
  end
end

# Copies test files to the user's home dir
# and return the realtime for doing so.
def install_tests
  time = Benchmark.realtime do
    FileUtils.cp_r('../../test_files/Code', "#{ENV['HOME']}/Tmp")
    FileUtils.cp_r('../../test_files/Documents', "#{ENV['HOME']}/Tmp")
    FileUtils.cp_r('../../test_files/Downloads', "#{ENV['HOME']}/Tmp")
    FileUtils.cp_r('../../test_files/Music', "#{ENV['HOME']}/Tmp")
    FileUtils.cp_r('../../test_files/Videos', "#{ENV['HOME']}/Tmp")
    FileUtils.cp_r('../../test_files/Pictures', "#{ENV['HOME']}/Tmp")
  end
  return time
end
