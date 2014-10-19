require 'serverspec'

set :os, :arch => 'x86_64', :family => 'debian', :distro => 'debian', :release => 7
set :backend, :nsenter
set :nsenter_pid, `docker inspect -f '{{ .State.Pid }}' tomcat8`

puts "#{Specinfra.configuration.nsenter_pid}"

describe package('wget') do
  it { should be_installed }
end
