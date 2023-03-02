task :install do
  Dir.chdir("androgee/bin/") do
    puts("Installing tests..")
    begin
      ruby("install")
    rescue
      sh("install_deps.sh")
      retry
    end
  end
end

task :bench_cpu do
  puts("Benching your CPU")
end

task :bench_gpu do
  puts("Benching your GPU")
end

def install_deps
  Dir.chdir("androgee/") do
    sh("install_deps.sh")
  end

end