require 'serverspec'

set :os, :arch => 'x86_64', :family => 'debian', :distro => 'Ubuntu', :release => 14 
set :backend, :nsenter
set :nsenter_pid, ENV['NSENTER_PID']

puts "#{Specinfra.configuration.nsenter_pid}"
