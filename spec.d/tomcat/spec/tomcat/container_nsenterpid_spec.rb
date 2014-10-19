require 'serverspec'

set :os, :arch => 'x86_64', :family => 'debian', :distro => 'debian', :release => 7
set :backend, :nsenter
set :docker_cid, "tomcat8"
set :nsenter_pid, nil

puts "#{Specinfra.configuration.docker_cid}"

describe package('wget') do
  it { should be_installed }
end
